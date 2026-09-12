<script setup lang="ts">
import { ref } from 'vue'
import { LockKeyhole } from 'lucide-vue-next'
import AppButton from '../../components/AppButton.vue'
import AppInput from '../../components/AppInput.vue'
import BrandLogo from '../../components/BrandLogo.vue'

const masterPassword = ref('')
</script>

<template>
  <main class="unlock-view">
    <div class="unlock-view__content">
      <BrandLogo />
      <span class="unlock-view__mark" aria-hidden="true"><LockKeyhole :size="24" /></span>
      <header>
        <h2>解锁密码库</h2>
        <p>输入主密码以继续查看本次会话中的项目。</p>
      </header>
      <form @submit.prevent>
        <AppInput
          v-model="masterPassword"
          label="主密码"
          type="password"
          autocomplete="current-password"
          placeholder="输入主密码"
        />
        <AppButton type="submit">解锁</AppButton>
      </form>
      <p class="unlock-view__boundary">此页面不会验证或保存主密码。</p>
      <button class="unlock-view__account" type="button">切换账户</button>
    </div>
  </main>
</template>

<style scoped>
.unlock-view {
  display: grid;
  min-height: 680px;
  padding: 52px 24px;
  place-items: center;
  background: var(--color-surface);
}

.unlock-view__content {
  display: grid;
  width: min(100%, 380px);
  gap: 24px;
}

.unlock-view__mark {
  display: grid;
  width: 52px;
  height: 52px;
  margin-top: 8px;
  border: 1px solid var(--color-border);
  border-radius: 15px;
  place-items: center;
  color: var(--color-brand);
}

.unlock-view header,
.unlock-view form {
  display: grid;
}

.unlock-view header {
  gap: 7px;
}

.unlock-view h2,
.unlock-view p {
  margin: 0;
}

.unlock-view h2 {
  font-size: 30px;
  letter-spacing: -0.04em;
}

.unlock-view header p,
.unlock-view__boundary {
  color: var(--color-text-secondary);
  font-size: 13px;
}

.unlock-view form {
  gap: 18px;
}

.unlock-view__boundary {
  padding-top: 18px;
  border-top: 1px solid var(--color-border);
}

.unlock-view__account {
  min-height: 44px;
  justify-self: start;
  padding: 0;
  border: 0;
  background: transparent;
  color: var(--color-text-secondary);
  font-size: 13px;
}
</style>
