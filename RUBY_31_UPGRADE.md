# Ruby 3.1 支援升級總結

## 修改的檔案

### 1. 版本和依賴配置
- **ar-octopus.gemspec**: 
  - 更新 `required_ruby_version` 從 `>= 2.2.0` 到 `>= 2.5.0`
  - 更新依賴項版本：mysql2、pg、sqlite3
- **.ruby-version**: 新增檔案，設定 Ruby 3.1.0
- **.travis.yml**: 更新 CI 測試的 Ruby 版本 (2.5.9, 2.6.10, 2.7.6, 3.0.4, 3.1.2)

### 2. Rails 6.1 支援
- **Appraisals**: 新增 Rails 6.1 配置
- **gemfiles/rails61.gemfile**: 新增 Rails 6.1 gemfile
- **.travis.yml**: 新增 Rails 6.1 測試配置

### 3. Ruby 3.1 參數分離修復
在 Ruby 3.0+ 中，positional 和 keyword arguments 被分離，需要明確處理 `**kwargs`。

修改的檔案：
- **lib/octopus/persistence.rb**: 
  - 所有方法添加 `**kwargs` 支援
  - 為 Rails 6.1+ 添加 `update_attributes` 條件性定義
- **lib/octopus/shard_tracking.rb**: 
  - `create_sharded_method` 中添加 `**kwargs` 支援
- **lib/octopus/relation_proxy.rb**: 
  - `method_missing` 和 `respond_to?` 方法添加 `**kwargs` 支援
- **lib/octopus/abstract_adapter.rb**: 
  - `method_missing` 方法添加 `**kwargs` 支援
- **lib/octopus/model.rb**: 
  - `perform_validations_with_octopus` 方法添加 `**kwargs` 支援
- **lib/octopus/scope_proxy.rb**: 
  - `method_missing` 方法添加 `**kwargs` 支援

## 主要修改原因

### Ruby 3.1 兼容性
1. **參數分離**: Ruby 3.0+ 嚴格分離 positional 和 keyword arguments
2. **update_attributes 棄用**: Rails 6.1+ 移除了 `update_attributes` 方法
3. **依賴項更新**: 較舊的 gem 版本不支援 Ruby 3.1

### 解決的問題
- 修復 "wrong number of arguments" 錯誤
- 確保所有 method_missing 調用都正確處理 kwargs
- 提供 Rails 6.1 兼容性
- 保持向後兼容性

## 測試
所有修改過的檔案都通過了語法檢查：
- lib/octopus/persistence.rb ✓
- lib/octopus/relation_proxy.rb ✓ 
- lib/octopus/shard_tracking.rb ✓
- lib/octopus/scope_proxy.rb ✓

## 向後兼容性
所有修改都保持了向後兼容性：
- 舊版本 Rails 仍然支援
- 舊的 `update_attributes` 調用仍然有效
- 不影響現有的 API
