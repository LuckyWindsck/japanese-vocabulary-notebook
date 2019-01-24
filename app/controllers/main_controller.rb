class MainController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_user

  def index
  end
  def help
  end
  def profile
    @vocab = @user.vocabularies
    @vocab_count = @vocab.count
    @part_of_speech = Hash.new(0)
    @vocab.all.each do |v|
      @part_of_speech[v.part_of_speech] += 1
    end
  end
  def under_construction
  end
  def vocab_list
    @vocab = Vocabulary.includes(:user).sort_by {|v| [v.part_of_speech, v.pronunciation.length, v.vocab.length]}
    @col = {
      :part_of_speech => '品詞',
      :vocab => '単語',
      :pronunciation => '読み方',
    }
  end
  def new_vocab
    @vocabulary = Vocabulary.new
  end
  # POST /students
  # POST /students.json
  def create_vocab

    @vocabulary = Vocabulary.new(vocab_params.merge(user: @user))

    respond_to do |format|
      if @vocabulary.save
        format.html { redirect_to vocab_list_path, notice: '単語の追加が成功しました。' }
        format.json { render :show, status: :created, location: @vocabulary }
      else
        format.html { render :new }
        format.json { render json: @vocabulary.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vocabulary = Vocabulary.find(params[:id])
    @vocabulary.destroy
    respond_to do |format|
      format.html { redirect_to vocab_list_url, notice: '単語の削除が成功しました。' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = current_user
    end

    def vocab_params
      # params.require(:vocabulary).permit(:part_of_speech, :vocab, :pronunciation, :user_id)
      params.permit(:part_of_speech, :vocab, :pronunciation)
    end
end
