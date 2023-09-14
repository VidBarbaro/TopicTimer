<template>
    <nav>
        <img src="../assets/images/TopicTimerWhiteLogo.png" alt="topic timer logo">
        <section>
            <RouterLink class="link" to="/">Subjects</RouterLink>
            <RouterLink class="link" to="/about">History</RouterLink>
            <RouterLink class="link" to="/about">User</RouterLink>
        </section>
    </nav>
</template>

<style scoped>
template {
    margin: 0;
    padding: 0;
}

nav {
    background-color: #009688;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content:space-between;
}

img {
    width: 13rem;
    margin: 1rem 3rem;
}

section {
    display: flex;
    justify-content: space-evenly;
    width: 50%;
    font-size: 1.5rem;
}

.link {
    color: #F5F5F5;
    text-decoration: none;
}
</style>