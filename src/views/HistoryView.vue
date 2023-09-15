<script setup>
import moment from 'moment'
import { DoughnutChart, BarChart, LineChart } from 'vue-chart-3'
import { Chart, registerables } from "chart.js"
import 'chartjs-adapter-moment'

moment.locale('nl')
Chart.register(...registerables)
</script>

<template>
	<div class="w-75 m-auto">
		<BarChart v-if="selectedChart == 0" :chart-data="chartData" :options="chartOptions"/>
    	<DoughnutChart v-if="selectedChart == 1" :chart-data="chartData" :options="chartOptions"/>
    	<LineChart v-if="selectedChart == 2" :chart-data="chartData" :options="chartOptions"/>
	</div>
</template>

<script>
export default {
data() {
    return {
      selectedChart: 0,
	  chartOptions: {
		indexAxis: 'y',
      	responsive: true, 
      	maintainAspectRatio: false,
      	scales: {
        	x: {
          		stacked: true,
				type: 'time',
				min: '00:00',
          		max: '23:59',
                time: {
					parser: 'HH:mm',					
            		displayFormats: {
						hour: 'HH:mm'
            		}
                },
				ticks: {
					stepSize: 1,
					autoSkip: false,
				}
        	},
			y: {
				stacked: true,
			}
      	},
		plugins: {
			legend: {
        		position: 'bottom',
      		},
            tooltip: {
                callbacks: {
					title: function(tooltipItem) {
						return `${tooltipItem[0].label} - ${tooltipItem[0].dataset.label}`
					},
                    label: function(context) {
						let label = 'Data not correctly formated!'
                        if (context.dataset.label && context.parsed._custom.barStart >= 0 && context.parsed._custom.barEnd >= 0) {
							const startTime = moment(new Date(context.parsed._custom.barStart))
							const endTime = moment(new Date(context.parsed._custom.barEnd))
							const duration = moment.duration(endTime.diff(startTime))
                            label = `${startTime.format('HH:mm')} - ${endTime.format('HH:mm')}: ${duration.humanize()}`
                        }
                        return label;
                    }
                }
            }
        }
		},
      	chartData: {
      		labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saterday', 'Sunday'],
      		datasets: [
				  {
					label: 'Cleaning my room',
					data: [{ x: ['01:00', '11:00'], y: 'Monday' }],
					backgroundColor: 'red',
					barPercentage: 0.4,
				  },
        		{
				  label: 'Math',
        		  data: [{ x: ['12:00', '13:00'], y: 'Monday' }],
        		  backgroundColor: 'yellow',
				  barPercentage: 0.4,
        		},
      		],
    	}
	}
}
}
</script>