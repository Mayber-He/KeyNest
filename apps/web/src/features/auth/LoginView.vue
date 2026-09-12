<script setup lang="ts">
import { ref } from 'vue'
import AppButton from '../../components/AppButton.vue'
import AppInput from '../../components/AppInput.vue'
import BrandLogo from '../../components/BrandLogo.vue'

const email = ref('')
const password = ref('')
</script>

<template>
  <main class="auth-view">
    <div class="auth-view__content">
      <BrandLogo />
      <header>
        <h2>登录 KeyNest</h2>
        <p>访问你的密码库界面</p>
      </header>
      <form autocomplete="off" @submit.prevent>
        <AppInput v-model="email" label="邮箱" type="email" autocomplete="off" placeholder="name@example.com" />
        <AppInput v-model="password" label="账户密码" type="password" autocomplete="off" placeholder="输入账户密码" />
        <div class="auth-view__form-meta">
          <label><input type="checkbox" /> 保持登录</label>
          <button type="button">忘记账户密码</button>
        </div>
        <AppButton type="submit">登录</AppButton>
      </form>
      <p class="auth-view__boundary">此静态预览不会提交或验证输入；浏览器扩展或密码管理器仍可能读取字段，请勿输入真实凭据。</p>
      <p class="auth-view__switch">还没有账户？ <button type="button">创建账户</button></p>
    </div>
  </main>
</template>

<style scoped>
.auth-view {
  display: grid;
  min-height: 680px;
  padding: 52px 24px;
  place-items: center;
  background: var(--color-surface);
}

.auth-view__content {
  display: grid;
  width: min(100%, 380px);
  gap: 28px;
}

.auth-view header,
.auth-view form {
  display: grid;
}

.auth-view header {
  gap: 7px;
}

.auth-view h2,
.auth-view p {
  margin: 0;
}

.auth-view h2 {
  font-size: 30px;
  letter-spacing: -0.04em;
}

.auth-view header p,
.auth-view__boundary,
.auth-view__switch {
  color: var(--color-text-secondary);
  font-size: 13px;
}

.auth-view form {
  gap: 18px;
}

.auth-view__form-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  color: var(--color-text-secondary);
  font-size: 12px;
}

.auth-view__form-meta label {
  display: inline-flex;
  min-height: 44px;
  align-items: center;
  gap: 8px;
}

.auth-view__form-meta input {
  width: 16px;
  height: 16px;
  accent-color: var(--color-brand);
}

.auth-view button:not(.app-button) {
  min-height: 44px;
  padding: 0;
  border: 0;
  background: transparent;
  color: var(--color-text-secondary);
}

.auth-view__boundary {
  margin-top: -12px !important;
  padding-top: 18px;
  border-top: 1px solid var(--color-border);
}

.auth-view__switch button {
  color: var(--color-text) !important;
  font-weight: 620;
}
</style>
