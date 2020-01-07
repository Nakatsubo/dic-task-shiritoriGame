class ShiritoriGame
  attr_accessor :player_name, :histories

  def initialize(player_name)
    @player_name = player_name
    @histories = []
  end

  def self.rule
    rule_text = ''
    rule_text << "すべてカタカナで入力してください\n"
    rule_text << "最後に 'ン' がついたら負けです\n"
    rule_text << "同じ単語を使ったら負けです\n"
    rule_text
  end

  def self.all_words
    %w[リンゴ ゴリラ ラッパ パリ]
  end

  def start
    "\\_o< Hi, シリトリプレイヤー. Let's enjoy shiritori game\n"
  end

  # getter
  # def histories
  #   @histories
  # end

  # setter
  # def histories=(value)
  #   @histories = value
  # end

  def computer_attack
    if @histories.last == 'リンゴ'
      return 'ゴリラ'
    elsif @histories.last == 'パリ'
      return 'リンゴ'
    else
      return nil
    end
  end

  def validate_shiritori_rule(word)
    if word == nil
      return false
    elsif word.split("").last == "ン"
      return false
    elsif word.include?("リンゴ") && histories.include?("リンゴ")
      return false
    elsif word.split("").first != histories.last.split("").last
      return false
    else word.split("").first == histories.last.split("").last
      return true
    end
  end

  # def mock_method
  #   return true
  # end
end