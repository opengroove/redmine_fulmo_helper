fulmoヘルパープラグイン
======
[fulmo](https://github.com/opengroove/fulmo)用に標準の[Redmine API](http://www.redmine.org/projects/redmine/wiki/Rest_api)では不足している機能を提供します。

動作環境
------
Redmine1.4 と Redmine 2.0 をサポートしています。動作の確認は以下の環境で行いました。
 * Redmine 1.4.2 + ruby 1.8.7
 * Redmine 1.4.2 + ruby 1.9.3
 * Redmine 2.0.0 + ruby 1.8.7
 * Redmine 2.0.0 + ruby 1.9.3


インストール
------
### Redmine 1.4
```sh
% cd REDMINE_ROOT
% ./script/plugin install git://github.com/opengroove/redmine_fulmo_helper.git
```

### Redmine 2.0
```sh
% cd REDMINE_ROOT/plugins
% git clone git://githib.com/opengroove/redmine_fulmo_helper.git 
```


プロジェクトトラッカー一覧API
------
```
/projects/:project_id/trackers.:format
```

*:project_id* で指定したプロジェクトで使用可能なトラッカーの一覧を戻します。

### リクエストの例
```
GET /projects/1/trackers.xml
GET /projects/redmine/trackers.xml
```

### レスポンスの例
```xml
<?xml version="1.0" encoding="UTF-8"?>
<trackers type="array">
  <tracker>
    <id>1</id>
    <name>バグ</name>
  </tracker>
  <tracker>
    <id>2</id>
    <name>機能</name>
  </tracker>
</trackers>
```

### 権限
「プロジェクトの閲覧(view_issues)」権限が必要です。

チケットフィールド一覧API
------
```
/projects/:project_id/issues/attibutes.:format?tracker_id=:tracker_id
```

チケットで使用可能なフィールドの一覧を戻します。指定されているプロジェクトとトラッカーに対してログインユーザーの権限で使用可能なフィールドを戻します。

### リクエストの例
```
GET /projects/redmine/issues/attributes.xml?tracker_id=1
```

### レスポンスの例
```xml
<?xml version="1.0" encoding="UTF-8"?>
<issue_attributes>
  <standard_attributes type="array">
    <standard_attribute name="status_id">
      <label>ステータス</label>
      <format>list</format>
      <possible_values type="array">
        <value id="1">新規</value>
        <value id="5">新規</value>
      </possible_values>
      <is_required>true</is_required>
      <default_value>1</default_value>
    </standard_attribute>
    ...
  </standard_attributes>
  <custom_attributes type="array">
    <custom_attribute id="1">
      <name>テクスト</name>
      <format>string</format>
      <pssible_values type="array"/>
      <regexp/>
      <min_length/>
      <max_length/>
      <is_required>false</is_required>
      <default_value/>
      <multiple>false</multiple>
    </custom_attribute>
    <custom_attribute>    
      <id>2</id>
      <name>ムニュ</name>
      <format>list</format>
      <possible_values type="array">
        <value>アントレ</value>
        <value>ポアソン</value>
      </possible_values>
      <regexp/>
      <min_length/>
      <max_length/>
      <is_required>false</is_required>
      <default_value/>
      <multiple>false</multiple>
    </custom_attribute>
    ...
  </custom_attributes>
</issue_attributes>
```
 
### 解説
#### \<format\>
\<format\>にはカスタムフィールドの「書式」の値がそのまま出力されます。
```
string
text
int
float
list
date
bool
user
version
```
ただし標準フィールドの「予定工数(esimated_hours)」については、「2h30m」などの特別な形式で入力が可能なので「hours」という値を出力します。

#### \<format_label\>
\<format\>の表示用テキストが出力されます。

#### \<unit_label\>
単位の表示名称が出力されます。現在のバージョンでは「予定工数」フィールドで入力欄の後ろに続くテキストが出力されます。

#### 要素の省略
値が空文字列あるいはfalseの場合にはその要素が省略される場合があります。例えば\<multiple\>は値がtrueの場合には出力されますが値がfalseの場合には省略される場合があります。同様に\<regexp\>も、値が空の場合には省略される場合があります。

### 権限
「チケットの追加(add_issues)」権限が必要です。


テストの実行
------
### Redmine 1.4
```sh
% cd REDMINE_ROOT
% rake db:test:load
% rake test:plugins PLUGIN=redmine_fulmo_helper TESTOPTS=-v
```

### Redmine 2.0
```sh
% cd REDMINE_ROOT
% rake db:test:load
% rake test TEST="plugins/redmine_fulmo_helper/test/**/*_test.rb" TESTOPTS=-v
```
