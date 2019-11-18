# Shiritori ゲームを作ってみよう ver.20191021
- ペアでやってる方は、随時、気になってること、気づいたことをお話してください:)
- `$ ` はコマンドラインでの実行を表現しているだけなので、打たなくでOKです:)
- テスティングライブラリは rspec を使います https://github.com/rspec/
- コードはコピペしてもいいですが、写経した方が理解しやすく、記憶に残りやすいので、打つのをオススメします:)

# 1歩目( `ShiritoriGame` クラスを作って、specファイルを動かしてみる)

## shiritori_game ディレクトリ作成してみる
```
$ mkdir shiritori_game
$ cd shiritori_game
```

## git を使えるようにしてみる
```
$ git init
```

#### メモ
※ キリのいいところで `git commit` しましょう:)

## RSpec の準備 (インストールして init) してみる
```ruby
$ gem i rspec
$ rspec --init
```

#### メモ
- どんなファイルが作られました？
- ※ commit してますか？
  - `$ git add .`
  - `$ git commit -m 'rspec --init'`
  - ↑コマンド実行してファイルが作られる場合、コマンドをそのままコミットメッセージ入れるとなにかと便利:)
- どんなファイルが作られました？
- 他に気になることはありますか(?_?)



## ShiritoriGame クラスを作ってみる
- `shiritori_game/shiritori_game.rb` というファイルを作って以下のコードを入力してください

```ruby
class ShiritoriGame
  def self.rule
    rule_text = ''
    rule_text << "すべてカタカナで入力してください\n"
    rule_text << "最後に 'ン' がついたら負けです\n"
    rule_text << "同じ単語を使ったら負けです\n"
    rule_text
  end
end
```

#### メモ
- ※ commit してますか？commit メッセージはわかりやすいですか？
- 今実装した `.rule` はクラスメソッドですか？インスタンスメソッドですか？
- 他に気になることはありますか(?_?)

## irb で ShiritoriGame クラスを使ってみる
- `shiritori_game` ディレクトリ直下で実行
```ruby
$ irb
irb(main):001:0> require './shiritori_game'
=> true
irb(main):002:0> puts ShiritoriGame.rule
すべてカタカナで入力してください
最後に 'ン' がついたら負けです
同じ単語を使ったら負けです
=> nil
```

#### メモ
- 他に気になることはありますか(?_?)



## specファイル(shiritori_game_spec.rb)を作ってみる
- `shiritori_game/spec/shiritori_game_spec.rb` ファイルを作って以下のコードを入力してください

```ruby
require './shiritori_game'

RSpec.describe ShiritoriGame do
  describe '.rule' do
    it 'シリトリのルールが表示される' do
      expect(ShiritoriGame.rule).to eq(puts(%Q|
        すべてカタカナで入力してください
        最後に 'ン' がついたら負けです
        同じ単語を使ったら負けです
      |))
    end
  end
end
```

#### メモ
- ※ commit してますか？
- `.rule` と書いてるのはどういう意味でしょうか？
- 他に気になることはありますか(?_?)



## spec を実行してみる
- `shiritori_game` ディレクトリ直下で実行
```
$ rspec spec/shiritori_game_spec.rb
```

- 出力結果
```
$ rspec spec/shiritori_game_spec.rb

      すべてカタカナで入力してください
      最後に 'ン' がついたら負けです
      同じ単語を使ったら負けです


        すべてカタカナで入力してください
        最後に 'ン' がついたら負けです
        同じ単語を使ったら負けです

.

Finished in 0.00258 seconds (files took 0.09027 seconds to load)
1 example, 0 failures
```


#### メモ
- greenになったら（specが通ったら）、ちゃんと spec が機能しているかを確認するため、 red（specが通らない状態）になるか確認してみましょう
  - どうするとspecが通らないようになると思いますか？
- 他に気になることはありますか(?_?)



# 2歩目( `.all_words` メソッドを実装してみる)

## シリトリゲームで使う全部の単語を取得する、`.all_words` メソッドを実装してください
- spec を先に書きます（TDD〜)

```ruby
  describe '.all_words' do
    it { expect(ShiritoriGame.all_words).to eq ["リンゴ", "ゴリラ", "ラッパ", "パリ"] }
  end
```

- 実行して、specが落ちることを確認します

```
$ rspec spec/shiritori_game_spec.rb

      すべてカタカナで入力してください
      最後に 'ン' がついたら負けです
      同じ単語を使ったら負けです


        すべてカタカナで入力してください
        最後に 'ン' がついたら負けです
        同じ単語を使ったら負けです

.F

Failures:

  1) ShiritoriGame.all_words
     Failure/Error: it { expect(ShiritoriGame.all_words).to eq ["リンゴ", "ゴリラ", "ラッパ", "パリ"] }

     NoMethodError:
       undefined method `all_words' for ShiritoriGame:Class
     # ./spec/shiritori_game_spec.rb:15:in `block (3 levels) in <top (required)>'

Finished in 0.00245 seconds (files took 0.08972 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/shiritori_game_spec.rb:15 # ShiritoriGame.all_words
```

- `.all_words` メソッドを実装してください
  - 実装できましたか(?_?)
  - spec は通りましたか(?_?)
    - `rspec spec/shiritori_game_spec.rb`
- commit してますか？コミットメッセージは後で読んだときにわかりやすく書かれてますか？
  - commit のタイミングはどんなときがいいですか(?_?)
- `.all_words` メソッドはクラスメソッドですか？インスタンスメソッドですか？
  - ↑はどうして xxx メソッドだと思いますか？


# 3歩目( `#start` メソッドを実装してみる)
- シリトリゲームを始める `#start` メソッドを実装します
- spec ファイルはこちらです。この spec が通るように実装してください

```ruby
  describe '#start' do
    subject(:shiritori_game) { ShiritoriGame.new(player_name: 'シリトリプレイヤー') }
    it { expect(shiritori_game.start).to include("\\_o< Hi, シリトリプレイヤー. Let's enjoy shiritori game\n") }
  end
```

## ヒント
- `#start` はインスタンスメソッドです
  - `ShiritoriGame.new` メソッドでインスタンスを生成します
  - `player_name` を使いやすくしたいので、初期値に渡し、インスタンス内でデータを保持します
  - こうすることで同じインスタンス間では、 `player_name` を呼び出しやすくできて便利です:)
- `Class.new` メソッドを呼び出すと、 `initialize` メソッドが呼ばれます
  - spec を見ると、初期値に `player_name` が渡されています
  - `player_name` という属性を、読み込みと書き込みができるようにしたいです
    - `attr_accessor` を使うと便利です:)
- `#start` では、 `.new` した時に渡した `player_name` を利用して、メッセージを表示します
  - インスタンス間でデータが共有できて便利ですね＞＜
- debug には `binding.irb` を使うと便利です
  - どこまで想定どおりに動いてますか？
  - どこからがわからないか、説明できますか？
- 気になることはありますか？隣の人と相談できてますか(?_?)


## メモ
- commit してますか？コミットメッセージは、自分以外の人が読んでもわかりやすくなっていますか？
- 手元で動かしてみたい場合は、spec からも実行できますし、以下のように呼び出してみることもできます
```ruby
$ irb
irb(main):001:0> require './shiritori_game'
=> true
irb(main):002:0> sg = ShiritoriGame.new(player_name: 'ぷれいやーのなまえ〜')
=> #<ShiritoriGame:0x00007fc1bf8b36b0 @player_name="ぷれいやーのなまえ〜">
irb(main):003:0> sg.start
\_o< Hi, ぷれいやーのなまえ〜. Let's enjoy shiritori game
=> nil
```

## メモ
- `ShiritoriGame#start` メソッドは、この後また6歩目で更新しますが、一旦寝かせます:)


# 4歩目(computerの攻撃メソッドを実装してみる)
- 以下の spec を追加してください
- rspec メモ
  - [RSpecによるユニットテストの書き方 – recompile.net]( https://recompile.net/posts/how-to-write-unit-test-with-rspec.html )
  - `describe`: http://www.betterspecs.org/jp/#describe
  - `subject`: http://www.betterspecs.org/jp/#subject
  - `let`: http://www.betterspecs.org/jp/#let
  - `context`: http://www.betterspecs.org/jp/#contexts

```ruby

  describe '#computer_attack' do
    subject(:shiritori_game_computer_attack) { shiritori_game.computer_attack }
    let(:shiritori_game) { ShiritoriGame.new(player_name: 'シリトリプレイヤー') }

    context 'ShiritoriGame#histories 最後が リンゴ のとき' do
      before { shiritori_game.histories << 'リンゴ' }

      it 'ゴリラが返ってくること' do
        expect(shiritori_game_computer_attack).to eq('ゴリラ')
      end
    end

    context 'ShiritoriGame#histories 最後が パリ のとき' do
      before { shiritori_game.histories << 'パリ' }

      it 'リンゴが返ってくること' do
        expect(shiritori_game_computer_attack).to eq('リンゴ')
      end
    end

    context 'ShiritoriGame#histories 最後が リンゴ, ゴリラ, ラッパ, パリ 以外のとき' do
      before { shiritori_game.histories << 'イヌ' }

      it 'nil が返ってくること' do
        expect(shiritori_game_computer_attack).to eq(nil)
      end
    end
  end

```

- commit してますか？
- spec が書けたら、実行して落ちるかどうかを確認してください
  - specの意味は全部わかりますか？
  - 気になるところはありますか？となりの人やメンターと相談・確認してみてください
- spec が通るように実装を追加してください
- spec 内にでてくる `ShiritoriGame#histories` は
  - `ShiritoriGame` インスタンスで、どんな単語でシリトリされたかがわかる配列（ `histories` ）が欲しいです
  - どう実装するとよさそうでしょうか？
  - 初期化はどこでするとよいでしょうか？
- なにか気になるところはありますか(?_?)


# 5歩目(シリトリのルールのあっているか判定するメソッドを実装してみる)

- 以下の spec を追加してください

```ruby

  describe '#validate_shiritori_rule' do
    subject(:shiritori_game_validate_shiritori_rule) { shiritori_game.validate_shiritori_rule(word) }
    let(:shiritori_game) { ShiritoriGame.new(player_name: 'シリトリプレイヤー') }

    context '引数の word が nil のとき' do
      let(:word) { nil }
      it { expect(shiritori_game_validate_shiritori_rule).to eq(false) }
    end

    context '引数の word の最後の文字が "ン" のとき' do
      let(:word) { 'ライオン' }
      it { expect(shiritori_game_validate_shiritori_rule).to eq(false) }
    end

    context '引数の word が ShiritoriGame#histories に含まれていたとき' do
      before { shiritori_game.histories << 'リンゴ' }
      let(:word) { 'リンゴ' }
      it { expect(shiritori_game_validate_shiritori_rule).to eq(false) }
    end

    context '引数の word の最初の文字が ShiritoriGame#histories の最後の文字と違うとき' do
      before { shiritori_game.histories << 'リンゴ' }
      let(:word) { 'ラッパ' }
      it { expect(shiritori_game_validate_shiritori_rule).to eq(false) }
    end

    context '引数の word の最初の文字が ShiritoriGame#histories の最後の文字と同じとき' do
      before { shiritori_game.histories << 'リンゴ' }
      let(:word) { 'ゴリラ' }
      it { expect(shiritori_game_validate_shiritori_rule).to eq(true) }
    end
  end

```

- キリのいいところで commit できてますか？
- spec の内容はちゃんと読めてますか？
  - `#validate_shiritori_rule` の `#` の意味はわかりますか？
  - 使っている各メソッドの意味はわかりますか？
  - 気になるところは隣の人やメンターと確認・相談してみてください〜
- spec が書けたら、実行して落ちるかどうかを確認してください
- spec が通るように実装を追加してください
  - どのコンテキストから通しても大丈夫です



# 6歩目の前に(rspec の「モック」の練習)
- 6歩目で `allow`, `receive`, `have_received` などのメソッドを使うので、その前に練習をします:)
- 以下の spec を書いて動かしてみましょう
  - メソッドの呼び出してる箇所など、コメントアウトなどを使って、テストが落ちたり通ったりすることを確認しながらやると、動きが理解しやすくなると思います

```ruby
  describe 'rspec practice' do
    # mock_object という名前のモックオブジェクト（仮のオブジェクト）を作る
    let(:mock_object) { double('mock_object') }

    describe 'allow and receive' do
      it 'mock_object オブジェクトから mock_method メソッドが呼ばれることを確認する' do
        # mock_object というオブジェクトから mock_method というメソッドが呼ばれることを監視する
        allow(mock_object).to receive(:mock_method)
        # mock_object の mock_method を呼ぶ
        mock_object.mock_method
        # mock_object は、mock_method が呼べるオブジェクトであることを確認する
        expect(mock_object).to have_received(:mock_method)
        # mock_object は、mock_method が一度だけ呼ばれるオブジェクトであることを確認する
        expect(mock_object).to have_received(:mock_method).once
      end

      it 'mock_object オブジェクトから mock_method メソッドが呼ばれると true を返すことを確認する' do
        # mock_object というオブジェクトから mock_method というメソッドが呼ばれることを監視し、呼ばれたときは true を返す
        allow(mock_object).to receive(:mock_method).and_return(true)
        # mock_object オブジェクトから mock_method を呼び、結果が true であることを確認する
        expect(mock_object.mock_method).to be_truthy
      end
    end

    describe 'ARFG.gets' do
      it 'ARFG オブジェクト から gets メソッドが呼ばれることを確認する' do
        # ARFG オブジェクトから gets メソッドが呼ばれることを監視する
        allow(ARGF).to receive(:gets)
        # gets メソッドを呼ぶ
        gets
        # ARGF オブジェクトから gets メソッドが呼ばれることを確認する
        expect(ARGF).to have_received(:gets)
      end

      it 'gets メソッドが呼ばれたとき、`げっつ！` という文字列が返ることを確認する' do
        # ARFG オブジェクトから gets メソッドが呼ばれることを監視し、呼ばれたときは
        allow(ARGF).to receive(:gets).and_return('げっつ！')
        # gets メソッドを呼び出し、結果が `げっつ！` であることを確認する
        expect(gets).to eq('げっつ！')
      end
    end
  end
```


# 6歩目(先攻か後攻かを判定してみる)
- `#start` メソッドの spec を更新します

```ruby
  # puts の絡むテストが複雑になりがちだったので start だけじゃなく start_message とメソッドを分けました
  describe '#start_message' do
    subject(:shiritori_game_start_message) { shiritori_game.start_message }
    let(:shiritori_game) { ShiritoriGame.new(player_name: 'シリトリプレイヤー') }

    it { expect(shiritori_game_start_message).to eq(
      "\\_o< Hi, シリトリプレイヤー. Let's enjoy shiritori game\n\\_o< 先行しますか？ yes | no\n"
    ) }
  end

  # 3歩目で書いた spec を更新します
  describe '#start' do
    subject(:shiritori_game_start) { shiritori_game.start }
    let(:shiritori_game) { ShiritoriGame.new(player_name: 'シリトリプレイヤー') }

    context 'yes の場合' do
      let(:gets_text) { 'yes' }

      it 'start_message が呼ばれること' do
        allow(shiritori_game).to receive(:start_message)
        allow(ARGF).to receive(:gets) { gets_text }
        shiritori_game_start
        expect(shiritori_game).to have_received(:start_message).once
      end

      it 'ShiritoriGame#attacker に player_name が設定されること' do
        allow(ARGF).to receive(:gets) { gets_text }
        shiritori_game_start
        expect(shiritori_game.attacker).to eq('シリトリプレイヤー')
      end

      it '先攻メッセージが表示されること' do
        allow(ARGF).to receive(:gets) { gets_text }
        messages = ''
        messages << "\\_o< Hi, シリトリプレイヤー. Let's enjoy shiritori game\n"
        messages << "\\_o< 先行しますか？ yes | no\n"
        messages << "\\_o< 先攻ですね。単語を入力してください\n"
        expect { shiritori_game_start }.to output(messages).to_stdout
      end
    end

    context 'no (yes以外) の場合' do
      let(:gets_text) { 'no' }

      it 'start_message が呼ばれること' do
        allow(shiritori_game).to receive(:start_message)
        allow(ARGF).to receive(:gets) { gets_text }
        shiritori_game_start
        expect(shiritori_game).to have_received(:start_message).once
      end

      it "ShiritoriGame#attacker に 'computer' が設定されること" do
        allow(ARGF).to receive(:gets) { gets_text }
        shiritori_game_start
        expect(shiritori_game.attacker).to eq('computer')
      end

      it '後攻メッセージが表示されること' do
        allow(ARGF).to receive(:gets) { gets_text }
        messages = ''
        messages << "\\_o< Hi, シリトリプレイヤー. Let's enjoy shiritori game\n"
        messages << "\\_o< 先行しますか？ yes | no\n"
        messages << "\\_o< 後攻ですね\n"
        expect { shiritori_game_start }.to output(messages).to_stdout
      end
    end
  end
```

## メモ
- このテストが通るように実装してください
  - やりたいことはテストに書いてあるはず！
- それぞれのテストで何をしているかわかりますか？
  - 各メソッドの意味はわかりますか？
  - ruby, rspec のリファレンスは利用できていますか？
  - `describe` と `context` の違いはどんなところですか？


# 6.5歩目(手元でも動かしてみる)
- `shiritori_game.rb` の最後に以下のコードを追加して、ターミナルから `ruby shiritori_game.rb` で呼び出して、動作を確認してみましょう

```ruby
##############
puts 'プレイヤー名をいれてください'
sg = ShiritoriGame.new(player_name: gets.chomp)
sg.start
```


## メモ
- 書いたコードの意味はわかりますか？
  - 気になるところはとなりの人と相談してみましょう:)
- これからシリトリができそうな感じに動いてますか？


# 7歩目(メソッドを組み合わせて次のターンを実行するメソッドを作ってみる)
- いままで作ったメソッドを組み合わせて、 `next_turn` というメソッドを作ります
  - `next_turn` メソッドで、シリトリ 1 ターンに必要なことを実行し、最後にまた次のターンを呼び出すことができれば、これでシリトリゲームが完成しそうですね
  - 再帰的に `next_turn` を呼ぶことにしてみましょう

## TODO: ここから更新する
- spec を追記
