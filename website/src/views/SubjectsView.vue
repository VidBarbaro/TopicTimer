<script setup>
import SubjectListItem from '../components/SubjectListItem.vue';
import data from '../assets/data.json'
console.log("Hello")
console.log(JSON.stringify(data))
</script>
<template>
  <div class="d-flex flex-column w-75 m-auto">
    <div class="w-100 mt-4 d-flex justify-content-between">
      <h2>Your subjects: </h2>
      <button class="btn bg-tt-yellow text-white">Add+</button>
    </div>
    <div class="w-100 mt-4">
      <div v-for="subject, index in data">
        <SubjectListItem :subject="subject"/>
        <hr v-if="index != data.length - 1" class="m-auto" />
      </div>
    </div>
  </div>
</template>

<style scoped>
hr {
    width: 85%;
}
</style>
