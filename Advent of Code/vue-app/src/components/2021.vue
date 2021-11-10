<template>
    <div>
        <div class="row mt-5" >
            <!-- Vertical Navigation -->
            <div class="col-2">
                <ul>
                    <li class="aoc-link" v-on:click="test01()">Test 01 | 10.11.2021</li>
                    <li class="aoc-link">Test 02 | 10.11.2021</li>
                    <li class="aoc-link">Day 01 | 01.12.2021</li>
                    <li class="aoc-link">Day 02 | 02.12.2021</li>
                    <li class="aoc-link">Day 03 | 03.12.2021</li>
                    <li class="aoc-link">Day 04 | 04.12.2021</li>
                    <li class="aoc-link">Day 05 | 05.12.2021</li>
                    <li class="aoc-link">Day 06 | 06.12.2021</li>
                    <li class="aoc-link">Day 07 | 07.12.2021</li>
                    <li class="aoc-link">Day 08 | 08.12.2021</li>
                    <li class="aoc-link">Day 09 | 09.12.2021</li>
                    <li class="aoc-link">Day 10 | 10.12.2021</li>
                    <li class="aoc-link">Day 11 | 11.12.2021</li>
                    <li class="aoc-link">Day 12 | 12.12.2021</li>
                    <li class="aoc-link">Day 13 | 13.12.2021</li>
                    <li class="aoc-link">Day 14 | 14.12.2021</li>
                    <li class="aoc-link">Day 15 | 15.12.2021</li>
                    <li class="aoc-link">Day 16 | 16.12.2021</li>
                    <li class="aoc-link">Day 17 | 17.12.2021</li>
                    <li class="aoc-link">Day 18 | 18.12.2021</li>
                    <li class="aoc-link">Day 19 | 19.12.2021</li>
                    <li class="aoc-link">Day 20 | 20.12.2021</li>
                    <li class="aoc-link">Day 21 | 21.12.2021</li>
                    <li class="aoc-link">Day 22 | 22.12.2021</li>
                    <li class="aoc-link">Day 23 | 23.12.2021</li>
                    <li class="aoc-link">Day 24 | 24.12.2021</li>
                    <li class="aoc-link">Day 25 | 25.12.2021</li>
                </ul>
            </div>

            <!-- Console Entries -->
            <div id="uiconsole" class="col-8" style="border: 1px solid #333340; height: 70vh; background-color: #10101a;" >
                <div class="aoc-link pl-2" v-for="log in uilogs" :key="log.data">
                    {{ log.data }}
                </div>
            </div>

            <!-- Actions -->
            <div class="col-2">
                <!-- Start, Edit Input -->
                <!-- Result -->

                <div class="d-flex pl-4" style="font-size: 1.25em;">
                    <div class="d-flex aoc-link"><p >[</p><i class="la la-play" style="margin-top: 0.35em;"></i><p>Execute ]</p></div>
                    <div class="aoc-link pl-4"><p>[ Show Input ]</p></div>
                </div>

                <div class="mt-5">
                    <h5 class="pl-4">Result:</h5>
                    <h5 class="aoc-link pl-4" style="background-color: #10101a;">{{result}}</h5>
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
            result: null,
            uilogs: [
                { "data": "> UI Console active" }
            ],
            userScrolled: false
        }
    },
    methods: {
        async test01(){
            for (let i = 0; i < 100; i++) { 
                this.log('Wohoo ' + i);
                await this.sleep(50);
            }
        },
        log(message){
            console.log(message);
            this.uilogs.push({"data": "> " + message});
        },
        sleep(ms){
            return new Promise((res) => {
                setTimeout(res, ms);
            });
        },
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

