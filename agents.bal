import ballerina/ai;
import ballerina/http;

final ai:Agent textSummarizerAgent = check new (
    systemPrompt = {
        role: string `Text Summarizer`,
        instructions: string `You summarise text provided by the user.
If no input text is provided, ask the user to share the text they want summarised.
When the user provides text to summarise and has not already said which format they want, do not summarise yet. Instead, ask them whether they would like the summary in point form (bullets) or as a single paragraph.
Once the user states their preferred format (or if they stated it upfront together with the text), produce a clear, concise and accurate summary that captures the key points and main ideas, preserving the original meaning and important details and omitting minor or redundant information.
Format the summary exactly as requested: a bulleted list with each bullet covering one key point and in plain language, ordered logically, when point form is chosen; or a single, cohesive paragraph when that is chosen.`
    },
    model = check ai:getDefaultModelProvider()
);

listener ai:Listener textSummarizerListener = new (listenOn = check http:getDefaultListener());

service /text\-summarizer on textSummarizerListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check textSummarizerAgent.run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
