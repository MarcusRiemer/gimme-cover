# coding: utf-8
require 'sinatra'
require 'byebug'
require 'combine_pdf'

get '/' do
  erb :index
end

post '/deckblattdazwischen' do
  param_exam = params.fetch "exam"
  param_cover = params.fetch "coversheet"

  path_exam = param_exam["tempfile"].path
  path_cover = param_cover["tempfile"].path

  filename = "Deckblätter_" + param_exam["filename"]

  pdf_combined = CombinePDF.new

  pdf_exam = CombinePDF.load(path_exam)
  CombinePDF.load(path_cover).pages.each do |participant_page|
    pdf_combined << participant_page << pdf_exam
  end

  attachment filename
  body pdf_combined.to_pdf
end