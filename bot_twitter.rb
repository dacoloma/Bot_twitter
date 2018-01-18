require 'twitter'
require 'dotenv'
require 'pry'

Dotenv.load

# quelques lignes qui enregistrent les clés d'APIs
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_API_KEY']
  config.consumer_secret     = ENV['TWITTER_API_SECRET']
  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

=begin          #supprimer cette ligne
topics = ["tea", "coffee"]
client.filter(track: topics.join(",")) do |object|
  puts object.text if object.is_a?(Twitter::Tweet)
end


tweet = client.user_timeline("marionsouzeau")
tweet.each do |msg|
    puts msg.full_text
end
=end                #et supprimer cette ligne pour verifier le fonctionnement

#effectue une recherche des 3 dernier tweet comprenant "marry me" vers le compte de Bieber
client.search("to:justinbieber marry me", result_type: "recent").take(3).collect do |tweet|
  puts "#{tweet.user.screen_name}: #{tweet.text}"
end

journalistes = ["jcunniet", "PaulLampon", "Aziliz31", "ssoumier", "marionsouzeau", "gaellombart", "bendarag", "AurelieLebelle", "julienduffe", "thomaspoupeau", "LilyRossignol", "ClairGuedon", "stephanieauguy", "claw_prolongeau", "_JulieMenard", "LColcomb", "Zlauwereys", "MeLonguet", "DorotheeLN", "NolwennCosson", "ADaboval", "Remibaldy", "bderveaux", "amandechap", "ELODIESOULIE", "nbongarcon", "HeloAb", "Panamorama", "gregplou", "BenoitBerthe", "LauraBruneau89", "Anthony_Lieures", "Sharonwaj", "mcsonkin", "pverduzier", "emiliel3", "Julien_MARION", "SophiFay", "bdelombre", "annalecerf", "AdriaBudry", "DejNikolic"]

#retweet le dernier tweet des journalistes ci-dessus toutes les 60 secondes pour eviter d'être ban
journalistes.each do |id|
    begin
        client.retweet(client.user_timeline(id,:count => 1))
            sleep(60)
    rescue Twitter::Error => e
        next
    end
end

#tweet le message ci-dessous aux journalistes ci-dessus toutes les 60 secondes pour éviter d'être ban
journalistes.each do |id|
    begin
        client.update("@#{id} Je suis élève à The Hacking Projet une formation gratuite au code et je viens de faire un bot Twitter après une semaine de formation seulement!")
        sleep(60)
    rescue Twitter::Error => e
        next
    end
end
