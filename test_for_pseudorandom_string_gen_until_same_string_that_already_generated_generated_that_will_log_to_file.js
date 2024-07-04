const fs = require('fs');
const path = require('path');
const os = require('os');

const generateRandomString = (length) => {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    const charactersLength = characters.length;

    for (let i = 0; i < length; i++) {
        result += characters.charAt(
            Math.floor(Math.random() * charactersLength)
        );
    }

    return result;
};

const formatNumberWithSpaces = (number) => {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
};

const findDuplicateString = (stringLength) => {
    const generatedStrings = new Set();
    const logFile = path.join(os.tmpdir(), 'generatedStrings.log');
    const startTime = Date.now();
    let counter = 0;

    // Read the log file to initialize the set
    if (fs.existsSync(logFile)) {
        const fileContents = fs.readFileSync(logFile, 'utf8').split('\n');
        for (const line of fileContents) {
            if (line.trim()) {
                generatedStrings.add(line.trim());
            }
        }
    }

    while (true) {
        const randomString = generateRandomString(stringLength);
        counter++;
        console.log(
            `Generated #${formatNumberWithSpaces(counter)}: ${randomString}`
        );

        if (generatedStrings.has(randomString)) {
            const endTime = Date.now();
            const duration = (endTime - startTime) / 1000; // convert milliseconds to seconds
            console.log(`Duplicate found: ${randomString}`);
            console.log(`Total time: ${duration} seconds`);
            break;
        }

        generatedStrings.add(randomString);

        if (counter % 1000 === 0) {
            fs.appendFileSync(logFile, `${randomString}\n`);
        }
    }
};

findDuplicateString(10);
