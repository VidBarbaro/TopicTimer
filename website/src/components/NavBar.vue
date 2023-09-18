<script setup>
import router from '../router'
</script>

<template>
    <nav class="d-flex align-items-center justify-content-between bg-tt-green">
        <div @click="router.push('/subjects')">
            <img role="button" class="nav-logo" src="../assets/images/TopicTimerWhiteLogo.png" alt="topic timer logo">
        </div>
        <section class="d-flex">
            <RouterLink class="link text-white" to="/">Home</RouterLink>
            <RouterLink class="link text-white" to="/subjects">Subjects</RouterLink>
            <RouterLink class="link text-white" to="/history">History</RouterLink>
            <RouterLink class="link text-white" to="/">User</RouterLink>
        </section>
    </nav>
</template>

<style scoped>
.nav-logo {
    width: 6.5rem;
    margin: 1rem 0 1rem 4rem;
}

.link {
    margin-right: 4rem;
    text-decoration: underline transparent;
    transition: text-decoration 300ms ease;
}

.link:hover {
    text-decoration-color: rgba(255, 255, 255, 1);
}

.router-link-active {
    font-weight: bold;
}
</style>