import { mount } from '@vue/test-utils'
import { vi } from 'vitest'
import AppInput from './AppInput.vue'

it('forwards native input attributes and listeners to the input element', async () => {
  const onBlur = vi.fn()
  const wrapper = mount(AppInput, {
    attrs: {
      name: 'account',
      autocomplete: 'username',
      required: true,
      readonly: true,
      'aria-label': '账户名',
      onBlur,
    },
  })

  const input = wrapper.get('input')
  expect(input.attributes()).toMatchObject({
    name: 'account',
    autocomplete: 'username',
    required: '',
    readonly: '',
    'aria-label': '账户名',
  })
  expect(wrapper.get('label').attributes('name')).toBeUndefined()

  await input.trigger('blur')
  expect(onBlur).toHaveBeenCalledOnce()
})
