<template>
  <div id="app">
    <Navigation v-on:setActivePage="setActive($event)" />
    <div v-show="this.activePage == 'Home'">
      <Home  />
    </div>
    <div v-show="this.activePage == '2021'">
      <Twozerotwoone  />
    </div>
  </div>
</template>

<script>
import Navigation from './components/Navigation.vue'
import Home from './components/Home.vue'
import Twozerotwoone from './components/2021.vue'

export default {
  name: 'App',
  components: {
    Navigation,
    Home,
    Twozerotwoone
  },
  data() {
    return {
      activePage: 'Home'
    }
  },
  methods: {
    setActive: function (page) {
      this.activePage = page;
    }
  }
}
</script>
