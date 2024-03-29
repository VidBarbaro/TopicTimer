<script setup>
	import HistoryChart from '../components/HistoryChart.vue'
	import jsonData from '../assets/data.json'
	import moment from 'moment'

	import VueDatePicker from '@vuepic/vue-datepicker';
	import '@vuepic/vue-datepicker/dist/main.css'
</script>

<template>
	<div class="w-75 m-auto d-flex flex-column gap-4">
		<div class="mt-4 d-flex justify-content-end">
			<div class="w-25 d-flex gap-4">
				<select v-model="chartType" role='button' class="topicSelector text-white bg-tt-yellow shadow-none border-0 form-select">
					<option class="bg-tt-offwhite" disabled>
						-- Select a chart type --
					</option>
					<option class="bg-tt-offwhite text-tt-offblack" v-bind:selected="chartType.toUpperCase() == 'BAR'">
						Bar
					</option>
					<!-- <option class="bg-tt-offwhite text-tt-offblack" v-bind:selected="chartType.toUpperCase() == 'DONUT'">
						Donut
					</option> -->
				</select>
				<VueDatePicker v-model="date" format="MM-dd-yyyy" :enableTimePicker="false" :clearable="false" inputClassName="text-white bg-tt-yellow border-0" />
			</div>
		</div>
		<HistoryChart :chartType="chartType" :selectedWeekDay="date" :trackedData="jsonData"/>
	</div>
</template>

<style>
.topicSelector {
	background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23ffffff' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e") !important;
}
.dp__input_icon {
	color: white;
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
			chartType: 'Bar',
			date: moment().format('MM-DD-YYYY'),
		}
	},
}
</script>