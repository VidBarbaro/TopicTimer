<script setup>
import topicListItem from '../components/topicsListItem.vue';
import topicModal from '../components/topicsModal.vue';
import data from '../assets/data.json';
</script>

<template>
  <div class="d-flex flex-column w-75 m-auto">
    <div class="w-100 mt-4 d-flex justify-content-between">
      <h2>Your topics: </h2>
      <button class="btn bg-tt-yellow text-white">Add+</button>
    </div>
    <div class="w-100 mt-4">
      <div v-for="topic, index in data">
        <topicListItem :topic="topic" @edit="value => startEditing(value)"/>
        <hr v-if="index != data.length - 1" class="m-auto" />
      </div>
    </div>
  </div>
  <div>
    <topicModal id="modal" v-if="editValue" :topic="editValue" @close="stopEditing" />
  </div>
</template>

<script>
export default {
  data() {
    return {
      editValue: null,
    }
  },
  methods: {
    startEditing(value) {
      this.editValue = value
    },
    stopEditing() {
      this.editValue = null
    },
    toggleModal(value) {
      if (value.editable) {
        this.editValue = value
        document.getElementById("modal").style.display = 'block';
      }
      else {
        document.getElementById("modal").style.display = 'none';
      }
      value.editable = !value.editable
    }
  }
}
</script>

<style scoped>
hr {
    width: 85%;
}

</style>
