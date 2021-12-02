import arg from 'arg';
import inquirer from 'inquirer';
import { runScript } from '../main'

function parseArgumentsIntoOptions(rawArgs) {
    const args = arg(
        {
            '--day': Number,
            '--part': Number,
            '--show-input': Boolean,
            '--debug': Boolean,
            '-d': '--day',
            '-p': '--part',
            '-s': '--show-input'
        },
        {
            argv: rawArgs.slice(2)
        }
    );
    return {
        day: args['--day'] || false,
        part: args['--part'] || false,
        year: args._[0],
        showInput: args['--show-input'] || false,
        debug: args['--debug'] || false
    }
}

async function promptForMissingOptions(options){

    const questions = [];
    if(!options.year) {
        questions.push({
            type: 'list',
            name: 'year',
            message: '🎅 Please choose which year you want to use.',
            choices: ['2021', '2022', '2023']
        });
    }

    if(!options.day) {
        questions.push({
            type: 'number',
            name: 'day',
            message: '🎅 Enter your wished day: ',
            default: 1,
        });
    }

    if(!options.part) {
        questions.push({
            type: 'number',
            name: 'part',
            message: '🎅 Enter your wished part: ',
            default: 2,
        });
    }

    const answers = await inquirer.prompt(questions);
    return {
        ...options,
        year: options.year || answers.year,
        day: options.day || answers.day,
        part: options.part || answers.part
    };
}

export async function cli(args) {
    console.clear();
    console.log("🎄 Advent of Code CLI 🎄");
    console.log("🎅 Ho Ho Hooo! Nice to see you. Ready to save christmas again?");
    let options = parseArgumentsIntoOptions(args);
    options = await promptForMissingOptions(options);
    runScript(options);
    console.log("\n");
}