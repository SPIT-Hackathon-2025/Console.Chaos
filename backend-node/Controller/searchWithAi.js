const { default: ollama } = require("ollama");
const LostFound = require("../Models/Lost&Found");

const searchWIthAI = async(req, res) => {
    try {
        const {text}=req.body
        const format_2 = {
            type: "object",
            properties: {
                id: {
                    type: "string",
                },
                info: {
                    type: "string", // Holds the structured summary of the found item
                },
            },
            required: ["id", "info"],
        };

        const userQuery = `Find lost and found entries matching this query: ${text}`;
        const lostFoundPosts = await LostFound.find()
                .populate("user", "username email imgUrl phoneNumber userType") // Include necessary fields
                .sort({ createdAt: -1 });
                const data = [
                    {
                      role: "system",
                      content: `You are a system that finds relevant lost and found entries based on user queries.
                        Analyze the dataset, considering the 'description', 'tags', 'createdAt', and user details.
                        If a date is provided in the query, prioritize matching entries within that timeframe.
                        If no date is given, match based on 'tags' and 'description'. 
                  
                        Convert the 'createdAt' timestamp into a readable format like 'February 9, 2025'.
                        If location is not available, exclude it.
                        If date is missing, use 'an unknown date'.
                        If username is missing, use 'an unknown person'.
                  
                        Return results in the following JSON format:
                        [
                          {
                            "id": "<matching entry ID>",
                            "info": "Your <item> was found at <location> on <formatted date> by <username>."
                          }
                        ]
                  
                        Here is the dataset:
                        ${JSON.stringify(lostFoundPosts)}
                      `,
                    },
                    {
                      role: "user",
                      content: text,
                    },
                  ];
                  
                  
        const response = await ollama.chat({
            model: "llama3.2",
            messages: data,
            format: format_2
        });
        console.log(response.message.content);
        
        const {id,info}=JSON.parse(response.message.content)
        const post=await LostFound.find({_id:id})
        res.send({post,info})
    } catch (error) {
        console.log(error);
        res.status(500)
    }
}

module.exports=searchWIthAI
