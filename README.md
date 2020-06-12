# five-eight
a R-shiny based web app that uses data science to maximizes scores for the mobile game Covet Fashion

# What is Five-Eight?
Covet Fashion is a mobile game based in competitive *style challenges* against other players. As most top players know, the key to consitently scoring well is to analyze trending *makeup* (MU), *hairstyles* (HS), and *skin tones* (ST) for each look; several such Facebook groups are dedicated to this kind of reporting and analysis. However, manually analyzing trends can be both difficult and time-consuming. Based on data from thousands of looks across several years, *five-eight* attempts to automate the process of determining trends and allow players to score the coveted top look: 5.8 stars.

# The Data
The data used for *five-eight* was scraped from multiple Facebook groups, including Muses of Covet, Covet Hair and Makeup Tips - TCS, Muses of Covet Series Clones, Covet Fashion Friends, and Covet Fashion Angels, and stored in an Excel spreadsheet.

# Coding
Categorization was done mostly by keyword analysis. In particular, challenge types were pre-identified, and textual analysis of single-word frequencies performed on each type, followed by manual selection of the most salient keywords. Below are the keywords associated with each category:
- magical: magic, fairy, goddess, enchanted, power, wings, mermaid
- royal: royal, prince, princess, queen, king, regal
- sports: sports, fitness, yoga, football, soccer, skating, gym, hiking, ballet, tennis
- formal: formal, movie star, celebrity, soiree, party, luxury
- professional: professional, lawyer, secretary, interview, teacher, sleek
- African: Africa, Egyptian
- Spanish: Spain, flamenco
- punk: punk, rebel, edgy, goth
- scifi: technology, futuristic, space, time travel
- horror: ghost, Frankenstein, witch, vampire, dead, zombie, goth, monster, dark, sinister
- bridal: wedding, bride, marriage, elope
- retro: retro, year numbers (50s, 60s, etc), steampunk, flapper
- Asian: Chinese, Japanese, Korean, Indian, Vietamnese, Thai
In addition, a catch-all category casual was added for most challenges that don't fall into a specific categories, involving mostly day-to-day activities such as shopping, cooking, family time, and such.

# Penalized Scoring
Because Covet Fashion allows an almost infinite combination of hair/makeup, there are some makeup choices that are generally less popular, but may score higher due to outliers in the dataset. Instead of removing these, I decided to use a penalty system that would "boost" popular makeup/hairstyles, and penalize less popular ones. This decision was made for two reasons:
- (1) the *mere exposure effect*: the psychological phenomenon that frequent exposure to something increases liking to it. In the context of Covet Fashion, MUs/HSs that are used more commonly tend to score higher, even if they are not intrinsically more "stylish".
- (2) the *bandwagon effect*: the psychological phenomenon that individual tend to follow what others do. In the context of Covet Fashion, players observe that certain MUs/HSs score higher; this leads to more players using it, and feeds back into the mere exposure effect.
These two effects create a positive feedback loop, boosting the scores of MU/HS/ST with higher usage.
<img src= "Voting Feedback Loop.png" />
