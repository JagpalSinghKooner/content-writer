#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// Load the files
const dbPath = path.join(__dirname, 'content-database.json');
const researchPath = path.join(__dirname, 'secondary-keywords-research.json');

console.log('Loading files...');
const database = JSON.parse(fs.readFileSync(dbPath, 'utf8'));
const research = JSON.parse(fs.readFileSync(researchPath, 'utf8'));

// Create a map of primary keywords to secondary keywords
const keywordMap = {};

Object.values(research).forEach(pillarArticles => {
    pillarArticles.forEach(article => {
        keywordMap[article.primary.toLowerCase()] = article.secondary.join(', ');
    });
});

console.log(`\nKeyword map created with ${Object.keys(keywordMap).length} entries`);

// Update the database
let updatedCount = 0;
database.articles.forEach(article => {
    const primaryKey = article.targetKeyword.toLowerCase();
    if (keywordMap[primaryKey]) {
        article.secondaryKeywords = keywordMap[primaryKey];
        updatedCount++;
        console.log(`✓ Updated: ${article.articleNumber} - ${article.title}`);
    } else {
        console.log(`✗ NOT FOUND: ${article.targetKeyword} (${article.articleNumber})`);
    }
});

// Save the updated database
fs.writeFileSync(dbPath, JSON.stringify(database, null, 2), 'utf8');

console.log(`\n==============================================`);
console.log(`✓ Successfully updated ${updatedCount} of ${database.articles.length} articles`);
console.log(`✓ Database saved to: ${dbPath}`);
console.log(`==============================================\n`);

// Verify
const emptyCount = database.articles.filter(a => !a.secondaryKeywords || a.secondaryKeywords === '').length;
if (emptyCount === 0) {
    console.log('✓ VERIFICATION PASSED: All articles now have secondary keywords!');
} else {
    console.log(`⚠ WARNING: ${emptyCount} articles still have empty secondary keywords`);
}
