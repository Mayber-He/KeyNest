import { mount, type VueWrapper } from '@vue/test-utils'
import VaultView from './VaultView.vue'

function buttonContaining(wrapper: VueWrapper, text: string) {
  const button = wrapper.findAll('button').find((candidate) => candidate.text().includes(text))
  if (!button) throw new Error(`找不到包含以下文本的按钮：${text}`)
  return button
}

it('switching away from an API key detail hides it before returning', async () => {
  const wrapper = mount(VaultView, { props: { selectedId: 'openai-example' } })

  await wrapper.get('button[aria-label="显示 API Key"]').trigger('click')
  expect(wrapper.text()).toContain('sk-example-public-not-a-real-key')

  await buttonContaining(wrapper, 'GitHub').trigger('click')
  await buttonContaining(wrapper, 'OpenAI').trigger('click')

  expect(wrapper.text()).not.toContain('sk-example-public-not-a-real-key')
  expect(wrapper.get('button[aria-label="显示 API Key"]').attributes('aria-label')).toBe('显示 API Key')
})
