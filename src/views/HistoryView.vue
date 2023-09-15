<script setup>
	import Chart from '../components/Chart.vue'
	import jsonData from '../assets/data.json'
</script>

<template>
	<div class="w-75 m-auto">
		<input type="button" value="date" />
		<Chart chartType="bar" selectedWeekDay="09-10-2023" :trackedData="jsonData"/>
	</div>
</template>
