import ballerina/ai;
import ballerinax/ai.anthropic;

configurable string anthropicApiKey = ?;
configurable anthropic:ANTHROPIC_MODEL_NAMES anthropicModelName = anthropic:CLAUDE_SONNET_4_5;

final ai:ModelProvider summarizerModelProvider = check new anthropic:ModelProvider(anthropicApiKey, anthropicModelName);
