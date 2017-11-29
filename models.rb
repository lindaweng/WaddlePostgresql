class Post < ActiveRecord::Base

end


# def reset()
#     while Time.now == Time.now
#         @time = ""
#         @post = Post.all
#         @post.each do |post|
#             puts post
#             @time = post.time
#             milTime = @time
#             if @time.include? " PM"
#                 milTime = @time.chomp(" PM").split(":")
#                 hour = milTime[0]
#                 min = milTime[1]
#             else
#                 milTime = @time.chomp(" AM").split(":")
#                 hour = milTime[0]
#                 min = milTime[1]
#             end
#             if Time.now.hour == hour.to_i and Time.now.min == min.to_i
#                 post.update(penguins: "")
#                 post.save()
#             end
#         end
#     end
# end