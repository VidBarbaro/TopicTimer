<template>
    <section>
        <span>
            <div class="circle" v-bind:style="{ 'background-color': subject.color }">{{ subject.shortName }}</div>
            <p>{{ subject.name }}</p>
        </span>
        <span>
            <i v-if="subject.editable" class="bi bi-pencil-square"></i>
            <i v-else class="bi bi-info-circle-fill"></i>
            <i class="bi bi-trash-fill"></i>
        </span>
    </section>
    <hr>
</template>

<style scoped>
section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px; /* Increased padding */
}

span {
    display: flex;
    align-items: center;
}

.circle {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 60px; /* Increased circle size */
    height: 60px; /* Increased circle size */
    border-radius: 50%;
    background-color: #3498db; /* Circle background color */
    color: #fff; /* Circle text color */
    font-size: 24px; /* Increased font size */
    margin-right: 20px; /* Adjusted spacing between circle and paragraph */
}

p {
    margin: 0; /* Remove default margin */
    font-size: 18px; /* Increased font size */
}

i {
    font-size: 24px; /* Increased font size for icons */
    margin-left: 20px; /* Adjusted spacing between icons */
}

hr {
    width: 85%;
    margin: auto;
}
</style>

<script>
export default {
    props: {
        subject: {
            type: Object,
            // required: true,
        }
    },
    mounted() {
    console.log(this.subject);
    }
}
</script>