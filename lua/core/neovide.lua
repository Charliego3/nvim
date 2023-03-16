local g = vim.g
local opt = vim.opt

if vim.g.neovide then
    vim.o.guifont = 'MonoLisa Nerd Font:h14'
    opt.linespace = 9
    -- 字体缩放
    g.neovide_scale_factor = 1

    -- padding
    g.neovide_padding_top = 0
    g.neovide_padding_bottom = 0
    g.neovide_padding_right = 0
    g.neovide_padding_left = 0


    -- background color
    local alpha = function()
        return string.format('%x', math.floor((255 * g.transparency) or 0.8))
    end
    g.neovide_transparency = 1
    g.transparency = 1
    g.neovide_background_color = '#0f1117' .. alpha()

    -- Floating blur amount
    g.neovide_floating_blur_amount_x = 10
    g.neovide_floating_blur_amount_y = 10

    -- Transparency
    g.neovide_transparency = 1

    -- Scroll animation length
    g.neovide_scroll_animation_length = 0.2

    -- Hiding the mouse when typing
    g.neovide_hide_mouse_when_typing = false
    g.neovide_underline_automatic_scaling = true
    g.neovide_refresh_rate = 60
    g.neovide_refresh_rate_idle = 5
    g.neovide_no_idle = true
    g.neovide_confirm_quit = true
    g.neovide_fullscreen = false
    g.neovide_remember_window_size = true
    g.neovide_profiler = false
    g.neovide_input_use_log = true
    g.neovide_input_macos_alt_is_meta = false
    g.neovide_touch_deadzone = 6.0
    g.neovide_touch_drag_timeout = 0.2
    g.neovide_cursor_animation_length = 0.08
    g.neovide_cursor_trail_size = 0.8
    g.neovide_cursor_antialiasing = true
    g.neovide_cursor_animate_in_insert_mode = true
    g.neovide_cursor_animate_command_line = true
    g.neovide_cursor_unfocused_outline_width = 0.125
    g.neovide_cursor_vfx_mode = 'railgun'
    -- g.neovide_curosr_vfx_opacity = 200
    -- g.neovide_cursor_vfx_particle_lifetime = 2
    -- g.neovide_cursor_vfx_particle_density = 8
    -- g.neovide_curosr_vfx_particle_speed = 3
    -- g.neovide_cursor_vfx_particle_phase = 2
    -- g.neovide_curosr_vfx_particle_curl = 2.0
end
