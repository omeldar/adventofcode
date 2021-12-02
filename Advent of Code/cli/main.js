const { exec } = require("child_process");
const path = require("path");

export async function runScript(options) {
    let dayFormatted = 0;
    if(options.day < 10)
        dayFormatted = "0" + options.day.toString();
    else
        dayFormatted = options.day;

    let pathInSrc = path.join(options.year.toString(), dayFormatted, options.part.toString());

    exec("node " + options.part + '.js', 
    { 
        cwd: path.join('src',options.year.toString(), dayFormatted )
    }, 
    (error, stdout) => {
        if(error){
            if(options.debug){
                console.error(error);
                console.log("");
            }   
            else {
                console.log('🎅 Ohh, something weird happened. Run this command with --debug to see full information.\n');
            }
        }
        if(stdout){
            console.log(`🎅 ${pathInSrc}: ${stdout}`);
        }
    })
}