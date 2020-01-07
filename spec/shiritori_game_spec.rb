require './shiritori_game'

RSpec.describe ShiritoriGame do
  describe '.rule' do
    it 'シリトリのルールが表示される' do
      expect(ShiritoriGame.rule).to eq("すべてカタカナで入力してください\n最後に 'ン' がついたら負けです\n同じ単語を使ったら負けです\n")
    end
  end

  describe '.all_words' do
    it { expect(ShiritoriGame.all_words).to eq ["リンゴ", "ゴリラ", "ラッパ", "パリ"] }
  end

  describe '#start' do
    subject(:shiritori_game) { ShiritoriGame.new(player_name: 'シリトリプレイヤー') }
    it { expect(shiritori_game.start).to include("\\_o< Hi, シリトリプレイヤー. Let's enjoy shiritori game\n") }
  end

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
end