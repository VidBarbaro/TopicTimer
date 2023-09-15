<script setup>
	import Chart from '../components/Chart.vue'
	import jsonData from '../assets/data.json'
</script>

<template>
	<div class="w-75 m-auto">
		<Chart chartType="bar" :trackedData="jsonData"/>
	</div>
</template>
