<template>
    <nav class="d-flex align-items-center justify-content-between bg-tt-green">
        <img class="nav-logo" src="../assets/images/TopicTimerWhiteLogo.png" alt="topic timer logo">
        <section class="w-25 d-flex justify-content-around">
            <RouterLink class="link text-white" to="/subjects">Subjects</RouterLink>
            <RouterLink class="link text-white" to="/history">History</RouterLink>
            <RouterLink class="link text-white" to="/">User</RouterLink>
        </section>
    </nav>
</template>

<style scoped>
.nav-logo {
    width: 6.5rem;
    margin: 1rem 3rem;
}

.link {
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