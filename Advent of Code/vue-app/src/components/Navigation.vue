<template>
    <nav class="navbar navbar-expand-lg" style="background-color: #0F0F23">
        <a class="navbar-brand aoc-glow" href="#" style="color: #00cc00">Advent of Code</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link aoc-link" v-bind:class="{ 'aoc-glow': activePage == 'Home'}" href="#" v-on:click="passActivePage('Home')">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link aoc-link" v-bind:class="{ 'aoc-glow': activePage == '2021'}" href="#" v-on:click="passActivePage('2021')">2021</a>
                </li>
            </ul>
        </div>
    </nav>
</template>
<script>
export default {
    name: 'Navigation',
    data() {
        return {
            activePage: 'Home'
        }
    },
    methods: {
        passActivePage(page){
            console.log(page);
            this.$emit('setActivePage', page);
            this.activePage = page;
        }
    }
}
</script>
