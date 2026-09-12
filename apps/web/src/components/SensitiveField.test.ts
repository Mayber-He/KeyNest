import { mount } from '@vue/test-utils'
import SensitiveField from './SensitiveField.vue'

it('hides, reveals, and hides a secret again', async () => {
  const wrapper = mount(SensitiveField, { props: { label: 'API Key', value: 'sk-public-example' } })
  expect(wrapper.text()).not.toContain('sk-public-example')
  await wrapper.get('[aria-label="显示 API Key"]').trigger('click')
  expect(wrapper.text()).toContain('sk-public-example')
  await wrapper.get('[aria-label="隐藏 API Key"]').trigger('click')
  expect(wrapper.text()).not.toContain('sk-public-example')
})
