import { mount } from '@vue/test-utils'
import { afterEach, vi } from 'vitest'
import SensitiveField from './SensitiveField.vue'

afterEach(() => {
  vi.unstubAllGlobals()
})

it('hides, reveals, and hides a secret again', async () => {
  const wrapper = mount(SensitiveField, { props: { label: 'API Key', value: 'sk-public-example' } })
  expect(wrapper.text()).not.toContain('sk-public-example')
  await wrapper.get('[aria-label="显示 API Key"]').trigger('click')
  expect(wrapper.text()).toContain('sk-public-example')
  await wrapper.get('[aria-label="隐藏 API Key"]').trigger('click')
  expect(wrapper.text()).not.toContain('sk-public-example')
})

it('emits copy without writing the secret to the clipboard', async () => {
  const writeText = vi.fn()
  vi.stubGlobal('navigator', { clipboard: { writeText } })
  const wrapper = mount(SensitiveField, { props: { label: 'API Key', value: 'sk-public-example' } })

  await wrapper.get('[aria-label="复制 API Key"]').trigger('click')

  expect(wrapper.emitted('copy')).toEqual([['sk-public-example']])
  expect(writeText).not.toHaveBeenCalled()
})

it('starts hidden after remount', async () => {
  const props = { label: 'API Key', value: 'sk-public-example' }
  const wrapper = mount(SensitiveField, { props })
  await wrapper.get('[aria-label="显示 API Key"]').trigger('click')
  expect(wrapper.text()).toContain('sk-public-example')

  wrapper.unmount()
  const remounted = mount(SensitiveField, { props })
  expect(remounted.text()).not.toContain('sk-public-example')
})
