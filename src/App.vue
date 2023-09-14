<script setup>
import { RouterLink, RouterView } from 'vue-router'
import NavBar from './components/NavBar.vue';
</script>

<template>
  <header>
    <NavBar />
  </header>

  <main>
    <RouterView />
  </main>

  <footer>
    <h3>Footer</h3>
  </footer>
</template>

<style>
* {
  margin: 0;
  padding: 0;
}
</style>
