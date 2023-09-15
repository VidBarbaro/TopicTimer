<script setup>
import moment from 'moment'
import { BarChart } from 'vue-chart-3'
import { Chart, registerables } from "chart.js"
import 'chartjs-adapter-moment'

moment.locale('nl')
Chart.register(...registerables)
</script>

<template>
    <BarChart v-if="chartType.toUpperCase() == 'BAR'" :chart-data="chartData" :options="barChartOptions"/>
</template>

<script>
export default {
props: {
    chartType: {
        type: String,
        required: true,
    },
    trackedData: {
        type: Object,
        required: true,
    }
},
computed: {
    chartData() {
      let formatedData = {
        labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saterday', 'Sunday'],
        datasets : []
      }

      this.trackedData.forEach(dataset => {
        let datasetDataObject = {
            label: dataset.name,
            data: [],
            backgroundColor: `${dataset.color}`,
            barPercentage: 0.6,
        }

        dataset.trackTimes.forEach(trackedTime => {
            console.log(trackedTime)
            const startTime = moment(new Date(trackedTime.start))
            const endTime = moment(new Date(trackedTime.end))

            datasetDataObject.data.push({
                x: [`${startTime.format('HH:mm')}`, `${endTime.format('HH:mm')}`],
                y: `${startTime.format('dddd')}`
            })
        })

        formatedData['datasets'].push(datasetDataObject)
      })

      console.log(formatedData)

      return formatedData
    }
},
data() {
    return {
      selectedChart: 0,
	  barChartOptions: {
		indexAxis: 'y',
      	responsive: true, 
      	maintainAspectRatio: false,
      	scales: {
        	x: {
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
						console.log(tooltipItem)
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
	}
}
}
</script>