<template>
    <div>
        <div class="row mt-5" >
            <!-- Vertical Navigation -->
            <div class="col-2">
                <ul>
                    <li class="aoc-link" v-on:click="setDay('Test 01')">Test 01 | 10.11.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Test 02')">Test 02 | 10.11.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 01')">Day 01 | 01.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 02')">Day 02 | 02.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 03')">Day 03 | 03.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 04')">Day 04 | 04.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 05')">Day 05 | 05.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 06')">Day 06 | 06.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 07')">Day 07 | 07.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 08')">Day 08 | 08.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 09')">Day 09 | 09.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 10')">Day 10 | 10.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 11')">Day 11 | 11.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 12')">Day 12 | 12.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 13')">Day 13 | 13.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 14')">Day 14 | 14.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 15')">Day 15 | 15.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 16')">Day 16 | 16.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 17')">Day 17 | 17.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 18')">Day 18 | 18.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 19')">Day 19 | 19.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 20')">Day 20 | 20.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 21')">Day 21 | 21.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 22')">Day 22 | 22.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 23')">Day 23 | 23.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 24')">Day 24 | 24.12.2021</li>
                    <li class="aoc-link" v-on:click="setDay('Day 25')">Day 25 | 25.12.2021</li>
                </ul>
            </div>

            <!-- Console Entries -->
            <div id="uiconsole" class="col-8 aoc-darkfield" style="height: 70vh;" scrollable>
                <div class="aoc-link pl-2" v-for="log in uilogs" :key="log.data">
                    {{ log.data }}
                </div>
            </div>

            <!-- Actions -->
            <div class="col-2">

                <!-- Execute 1, Show Input -->
                <div class="d-flex pl-4" style="font-size: 1.25em;">
                    <div class="d-flex aoc-link" v-on:click="execute(1)"><p >[</p><i class="la la-play" style="margin-top: 0.35em;"></i><p>Execute 1 ]</p></div>
                    <div class="aoc-link pl-4" v-on:click="showInput()"><p>[ Show Input ]</p></div>
                </div>

                <!-- Execute 2, Clarn Console -->
                <div class="d-flex pl-4" style="font-size: 1.25em;">
                    <div class="d-flex aoc-link" v-on:click="execute(2)"><p >[</p><i class="la la-play" style="margin-top: 0.35em;"></i><p>Execute 2 ]</p></div>
                    <div class="aoc-link pl-4" v-on:click="clearConsole()"><p>[ Clear Console ]</p></div>
                </div>

                <!-- Error if there is one -->
                <div v-if="err != null" class="ml-4 mr-2">
                    <span class="text-danger" style="font-size: 0.75em;">{{err}}</span>
                    <span class="text-danger ml-2" style="font-size: 0.75em; text-decoration: underline; cursor:pointer;" v-on:click="err = null;">Okay</span>
                </div>

                <!-- Result and copy to clipboard -->
                <div class="mt-5 ml-4 mr-2">
                    <div class="d-flex">
                        <h5 style="color: #d6d6d6">Result:</h5> 
                        <button class="aoc-button aoc-link ml-auto" type="button" 
                            v-clipboard:copy="result"
                            style="margin-bottom: 0.5em;"
                        >[Copy]</button>
                    </div>
                    
                    <h5 class="aoc-darkfield" style="color: #d6d6d6" clickable>{{result}}</h5>
                    
                </div>

                <!-- Cancel script execution -->
                <div v-if="result == 'loading...'">
                    <div class="aoc-link pl-4" v-on:click="cancel = true;"><p>[ Cancel ]</p></div>
                </div>

            </div>
        </div>
    </div>
</template>
<script>
export default {
    name: '2021',
    data() {
        return {
            result: "n/a",
            uilogs: [
                { "data": "AoC 21 > Advent of Code 2021" }
            ],
            currentDaySelection: null,
            userScrolled: false,
            inputs: [
                { name: "Test 01", inputVal: "Test Input For UI and Functionality tests."}
            ],
            activeInput: null,
            editInputActive: false,
            cancel: false,
            err: null
        }
    },
    methods: {
        setDay(day) {
            this.uilogs = [];
            this.currentDaySelection = day;
            this.log("Script selected: " + this.currentDaySelection);
            this.result = "n/a";
        },
        execute(part){
            if(this.result == 'loading...'){
                this.err = "You can not run 2 scripts at the same time. Wait or cancel running script.";
                return -1;
            }

            this.result = 'loading...';
            switch (this.currentDaySelection) {
                case 'Test 01':
                    switch(part) {
                        case 1:
                            this.test01p1().then(data => this.result = data);
                            break;
                        case 2:
                            this.test01p2().then(data => this.result = data);
                            break;
                        default:
                            this.log('No part ' + part + ' for ' + this.currentDaySelection + ' found.');
                            this.result = 'Not Found';
                            break;
                    }    
                    break;
                default:
                    this.log('Can not find function for this selection.')
                    this.result = 'n/a';
                    break;
            }
            this.cancel = false;
        },
        showInput() {
            this.log('Input for ' + this.currentDaySelection + ': \'' + this.inputs.find(i => i.name == this.currentDaySelection).inputVal + '\'');
        },
        log(message){
            console.log(message);
            this.uilogs.push({"data": "AoC 21: > " + message});
        },
        sleep(ms){
            return new Promise((res) => {
                setTimeout(res, ms);
            });
        },
        clearConsole(){
            this.uilogs = [];
            this.log('Advent of Code 2021');
        },
        async test01p1(){
            for (let i = 0; i < 100; i++) { 
                if(this.cancel)
                    return 'canceled';
                this.log('Wohoo ' + i);
                await this.sleep(50);
            }
            return "Test 01 P1 completed";
        },
        async test01p2(){
            for (let i = 0; i < 142; i++) { 
                if(this.cancel)
                    return 'canceled';
                this.log('Trutu ' + i);
                await this.sleep(35);
            }
            return "Test 01 P2 completed";
        }
    },
    watch : {
        uilogs : {
            handler: function () {
                /*
                let element = document.querySelectorAll('#uiconsole');
                if((element.scrollTop == element.scrollHeight - element.clientHeight) || element.scrollTop == 0)
                {
                    this.$nextTick(() => {
                        Array.from(document.querySelectorAll('#uiconsole > div')).pop().scrollIntoView();
                    })
                } */

                // if last not in view and no focus on scrollbar detected, continue:

                this.$nextTick(() => {
                    Array.from(document.querySelectorAll('#uiconsole > div')).pop().scrollIntoView();
                })
            }
        }   
    }
}
</script>

