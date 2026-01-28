#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Load the content database
const dbPath = path.join(__dirname, 'content-database.json');
const templatePath = path.join(__dirname, '..', 'templates', 'article-template.md');

let database;
try {
    database = JSON.parse(fs.readFileSync(dbPath, 'utf8'));
} catch (error) {
    console.error('Error loading content-database.json:', error.message);
    process.exit(1);
}

// Display available articles
console.log('\n=== HushAway® Article Creator ===\n');
console.log('Available articles to create:\n');

const draftArticles = database.articles.filter(a => a.status === 'draft' && a.wordCount === 0);

draftArticles.forEach((article, index) => {
    console.log(`${index + 1}. [Pillar ${article.pillar}] ${article.articleNumber} - ${article.title}`);
    console.log(`   Priority: ${article.priority} | Keyword: ${article.targetKeyword}`);
    console.log('');
});

if (draftArticles.length === 0) {
    console.log('No draft articles available to create!');
    process.exit(0);
}

rl.question('Enter article number to create (or "q" to quit): ', (answer) => {
    if (answer.toLowerCase() === 'q') {
        console.log('Cancelled.');
        rl.close();
        process.exit(0);
    }

    const choice = parseInt(answer) - 1;

    if (isNaN(choice) || choice < 0 || choice >= draftArticles.length) {
        console.log('Invalid selection.');
        rl.close();
        process.exit(1);
    }

    const article = draftArticles[choice];

    // Read template
    let template;
    try {
        template = fs.readFileSync(templatePath, 'utf8');
    } catch (error) {
        console.error('Error reading template:', error.message);
        rl.close();
        process.exit(1);
    }

    // Replace placeholders in template
    const today = new Date().toISOString().split('T')[0];

    let content = template
        .replace(/\[Article Title\]/g, article.title)
        .replace(/\[Number 1-7\]/g, article.pillar)
        .replace(/\[Pillar Name\]/g, article.pillarName)
        .replace(/\[PILLAR or X\.X\]/g, article.articleNumber)
        .replace(/\[Primary Keyword\]/g, article.targetKeyword)
        .replace(/\[Comma-separated list\]/g, article.secondaryKeywords || 'TBD')
        .replace(/\[Volume range\]/g, article.searchVolume)
        .replace(/\[Pillar Hub or Cluster\]/g, article.contentType)
        .replace(/\[3000 for hub \/ 1500 for cluster\]/g, article.minimumWordCount)
        .replace(/\[HIGH \/ MEDIUM \/ LOW\]/g, article.priority)
        .replace(/\[YYYY-MM-DD\]/g, today);

    // Create directory if it doesn't exist
    const filePath = path.join(__dirname, '..', article.filePath);
    const dirPath = path.dirname(filePath);

    if (!fs.existsSync(dirPath)) {
        fs.mkdirSync(dirPath, { recursive: true });
        console.log(`Created directory: ${dirPath}`);
    }

    // Check if file already exists
    if (fs.existsSync(filePath)) {
        rl.question(`File already exists at ${filePath}. Overwrite? (y/n): `, (overwrite) => {
            if (overwrite.toLowerCase() !== 'y') {
                console.log('Cancelled.');
                rl.close();
                process.exit(0);
            }

            writeArticleFile(filePath, content, article, today);
            rl.close();
        });
    } else {
        writeArticleFile(filePath, content, article, today);
        rl.close();
    }
});

function writeArticleFile(filePath, content, article, today) {
    try {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`\n✓ Article file created successfully!`);
        console.log(`Location: ${filePath}`);

        // Update database
        article.dateCreated = today;
        article.dateUpdated = today;

        fs.writeFileSync(dbPath, JSON.stringify(database, null, 2), 'utf8');
        console.log(`✓ Database updated`);

        console.log(`\nNext steps:`);
        console.log(`1. Open the file in your editor`);
        console.log(`2. Follow the agents.md workflow to write the article`);
        console.log(`3. Use the dashboard to track progress`);

    } catch (error) {
        console.error('Error creating file:', error.message);
        process.exit(1);
    }
}
