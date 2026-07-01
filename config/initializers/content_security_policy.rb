# frozen_string_literal: true

# https://guides.rubyonrails.org/security.html#content-security-policy-header
Rails.application.config.content_security_policy do |policy|
  policy.default_src     :self, :https
  policy.font_src        :self, :https, :data
  policy.img_src         :self, :https, :data, :blob
  policy.object_src      :self, :https, :blob
  policy.script_src      :self, 'https://static.maptoolkit.net' # self-hosted vite scripts are nonce'd; the one named CDN serves the MapToolKit route/track editor (mtk.js et al. + the map worker's rtl-text.js, loaded via importScripts which cannot carry a nonce). Do NOT broaden to blanket :https — that re-opens the any-origin <script src> bypass (DC-18).
  policy.style_src       :self, :unsafe_inline, :https, :data # allow inline styles background images and colors from concepts, and data: stylesheets (tui-image-editor theme)
  policy.worker_src      :self, :https, :blob

  policy.connect_src     :self, :https, :wss, :data # allow fetch() of data: URLs (tui-image-editor toDataURL save)
  policy.frame_ancestors :self
  policy.base_uri        :self

  unless Rails.env.development?
    policy.upgrade_insecure_requests true # rewrite http:// subresource requests to https://
  end

  if Rails.env.development?
    vite_port = ENV['VITE_RUBY_PORT'] || '3036'

    policy.connect_src(*policy.connect_src, "ws://localhost:#{vite_port}")
    policy.script_src(*policy.script_src, :unsafe_eval, "http://localhost:#{vite_port}")
  end
end

Rails.application.config.content_security_policy_nonce_generator = ->(_) { SecureRandom.base64(16) }
Rails.application.config.content_security_policy_nonce_directives = ['script-src']
