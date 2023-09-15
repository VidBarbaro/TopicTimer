<template>
  <div>
    <section>
      <h2>Your subjects: </h2>
      <button>Add+</button>
    </section>
    <section>
      <SubjectListItem :subject="data[0]"/>
      <SubjectListItem :subject="data[1]"/>
      <SubjectListItem :subject="data[2]"/>
      <SubjectListItem :subject="data[3]"/>
    </section>
  </div>
</template>

<style scoped>
div {
  display: flex;
  flex-direction: column;
  align-items: center;
}
section {
  width: 80%;
}
</style>

<script setup>
import SubjectListItem from '../components/SubjectListItem.vue';
import data from '../assets/data.json'
console.log("Hello")
console.log(JSON.stringify(data))
</script>
