<script setup lang="ts">
import { computed, onBeforeUnmount, ref } from 'vue'
import { Copy, RefreshCw } from 'lucide-vue-next'
import AppButton from '../../components/AppButton.vue'
import AppSidebar from '../../components/AppSidebar.vue'
import AppToast from '../../components/AppToast.vue'

const length = ref(20)
const revision = ref(0)
const copied = ref(false)
let copiedTimer: ReturnType<typeof setTimeout> | undefined
const options = ref([
  { id: 'lowercase', label: '小写字母', enabled: true },
  { id: 'uppercase', label: '大写字母', enabled: true },
  { id: 'numbers', label: '数字', enabled: true },
  { id: 'symbols', label: '特殊符号', enabled: true },
  { id: 'readable', label: '排除易混淆字符', enabled: false },
])

const samples = ['Kn!7tR#4mQ@9vL$2xP6s', 'Y8@cN4!wT7#pL2$rV9qM', 'M3#kZ8@tP5!xR7$vN2cQ']
const output = computed(() => {
  const source = samples[revision.value % samples.length]
  return source.repeat(Math.ceil(length.value / source.length)).slice(0, length.value)
})

function showCopied() {
  copied.value = true
  clearTimeout(copiedTimer)
  copiedTimer = setTimeout(() => (copied.value = false), 1800)
}

onBeforeUnmount(() => clearTimeout(copiedTimer))
</script>

<template>
  <div class="generator-view">
    <AppSidebar class="generator-view__sidebar" />
    <main>
      <header>
        <p>工具</p>
        <h2>密码生成器</h2>
        <span>按所选规则生成本地示例结果。</span>
      </header>

      <section class="generator-view__output" aria-labelledby="generator-result">
        <span id="generator-result">生成结果</span>
        <output>{{ output }}</output>
        <button type="button" aria-label="复制生成结果" @click="showCopied"><Copy :size="18" aria-hidden="true" /></button>
      </section>

      <section class="generator-view__controls" aria-labelledby="generator-options">
        <div class="generator-view__length">
          <label for="password-length">密码长度</label>
          <output for="password-length">{{ length }}</output>
          <input id="password-length" v-model.number="length" type="range" min="8" max="32" />
        </div>
        <fieldset>
          <legend id="generator-options">字符选项</legend>
          <label v-for="option in options" :key="option.id">
            <span>{{ option.label }}</span>
            <input v-model="option.enabled" type="checkbox" :aria-label="option.label" />
          </label>
        </fieldset>
        <AppButton @click="revision += 1">
          <RefreshCw :size="17" aria-hidden="true" />
          换一个示例
        </AppButton>
      </section>
      <AppToast v-if="copied" class="generator-view__toast" message="已复制" tone="success" />
    </main>
  </div>
</template>

<style scoped>
.generator-view { display: grid; min-height: 680px; grid-template-columns: 220px minmax(0, 1fr); }
.generator-view main { position: relative; width: min(100%, 720px); padding: 42px clamp(24px, 5vw, 64px); }
.generator-view header p,
.generator-view h2,
.generator-view header span { margin: 0; }
.generator-view header p { color: var(--color-text-muted); font-size: 12px; font-weight: 650; letter-spacing: .08em; }
.generator-view h2 { margin-top: 5px; font-size: 28px; letter-spacing: -.035em; }
.generator-view header span { display: block; margin-top: 7px; color: var(--color-text-secondary); font-size: 13px; }
.generator-view__output { position: relative; display: grid; margin: 30px 0 20px; padding: 18px 58px 18px 18px; border: 1px solid var(--color-border); border-radius: var(--radius-container); gap: 8px; }
.generator-view__output > span { color: var(--color-text-secondary); font-size: 12px; }
.generator-view__output output { overflow-wrap: anywhere; font-family: var(--font-mono); font-size: 18px; letter-spacing: .025em; }
.generator-view__output button { position: absolute; top: 18px; right: 12px; display: grid; width: 44px; height: 44px; padding: 0; border: 0; border-radius: 10px; place-items: center; background: transparent; color: var(--color-text-secondary); }
.generator-view__controls { display: grid; padding: 22px; border: 1px solid var(--color-border); border-radius: var(--radius-container); gap: 20px; }
.generator-view__length { display: grid; grid-template-columns: 1fr auto; align-items: center; gap: 12px; font-size: 13px; font-weight: 600; }
.generator-view__length output { font-family: var(--font-mono); }
.generator-view__length input { grid-column: 1 / -1; width: 100%; min-height: 44px; accent-color: var(--color-brand); }
.generator-view fieldset { margin: 0; padding: 0; border: 0; }
.generator-view legend { margin-bottom: 8px; font-size: 13px; font-weight: 600; }
.generator-view fieldset label { display: flex; min-height: 48px; border-top: 1px solid var(--color-border); align-items: center; justify-content: space-between; gap: 16px; color: var(--color-text-secondary); font-size: 13px; }
.generator-view fieldset input { width: 20px; height: 20px; accent-color: var(--color-brand); }
.generator-view .app-button { display: inline-flex; justify-self: start; align-items: center; gap: 8px; }
.generator-view__toast { position: absolute; right: 24px; bottom: 24px; }

@container product-frame (max-width: 719px) {
  .generator-view { display: block; }
  .generator-view__sidebar { display: none; }
  .generator-view main { padding: 28px 22px; }
  .generator-view__controls { padding: 18px; }
}
</style>
