<script setup lang="ts">
import { inject } from 'vue'
import { RouterView, routerKey } from 'vue-router'

const router = inject(routerKey, null)
</script>

<template>
  <main>
    <h1>KeyNest 界面概览</h1>
    <RouterView v-if="router" />
  </main>
</template>
