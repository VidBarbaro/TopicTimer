<script setup>
	import Chart from '../components/Chart.vue'
	import jsonData from '../assets/data.json'

	import VueDatePicker from '@vuepic/vue-datepicker';
	import '@vuepic/vue-datepicker/dist/main.css'
</script>

<template>
	<div class="w-75 m-auto d-flex flex-column gap-4">
		<div class="mt-4 d-flex justify-content-end">
			<div class="w-25 d-flex gap-4">
				<select class="topicSelector form-select">
					<option>
						Dummy item
					</option>
				</select>
				<VueDatePicker v-model="date" format="MM-dd-yyyy" :enableTimePicker="false" :clearable="false" inputClassName="vdp-input" />
			</div>
		</div>
		<Chart chartType="bar" :selectedWeekDay="date" :trackedData="jsonData"/>
	</div>
</template>

<style>
.topicSelector {
	color: white !important;
	background-color: #FFC107 !important;
	border: none !important;
	background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23ffffff' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e") !important;
}
.topicSelector:hover {
	cursor: pointer !important;
}
.topicSelector:focus {
	box-shadow: none !important;
}
.dp__input_icon {
	color: white;
}
.vdp-input {
	color: white;
	background-color: #FFC107;
	border: none;
}
.dp__today{
	border-color: #FFC107;
}
.dp__active_date {
	background-color: #FFC107;
}
.dp__action_select {
	background-color: #FFC107;
}
</style>

<script>
export default {
	data() {
		return {
			date: '09-15-2023'
		}
	}
}
</script>