import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String _baseUrl = 'https://sai.sharedllm.com/v1/chat/completions';
  static const String _model = 'gpt-oss:120b';

  static Future<String> getCompletion(String systemPrompt, String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': _model,
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': userMessage},
          ],
          'max_tokens': 2048,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? 'No response generated.';
      } else {
        return 'Error: Server returned status ${response.statusCode}. Please try again.';
      }
    } catch (e) {
      return 'Connection error. Please check your internet and try again.';
    }
  }

  static Future<String> documentCode(String code, String language) async {
    return getCompletion(
      'You are RepoDoc AI, an expert code documentation generator. Generate comprehensive documentation for the given code including: function descriptions, parameter types, return values, usage examples, and edge cases. Use proper documentation format for the specified language (JSDoc, docstrings, etc.).',
      'Document this $language code:\n\n```$language\n$code\n```',
    );
  }

  static Future<String> generateReadme(String projectName, String description) async {
    return getCompletion(
      'You are RepoDoc AI, a README generation expert. Create a professional, comprehensive README.md with: project title, badges, description, features, installation, usage, API reference, configuration, contributing guidelines, and license. Use proper markdown formatting.',
      'Generate a README for:\nProject: $projectName\nDescription: $description',
    );
  }

  static Future<String> generateApiDocs(String code, String framework) async {
    return getCompletion(
      'You are RepoDoc AI, an API documentation specialist. Generate comprehensive API documentation including: endpoints, methods, request/response schemas, authentication, error codes, rate limits, and usage examples. Format as clean, readable API reference.',
      'Generate API documentation for this $framework code:\n\n$code',
    );
  }

  static Future<String> analyzeArchitecture(String codeOrDescription) async {
    return getCompletion(
      'You are RepoDoc AI, a software architecture analyst. Analyze the codebase architecture and provide: design patterns used, component relationships, data flow, scalability considerations, potential improvements, and an ASCII architecture diagram.',
      'Analyze the architecture of:\n\n$codeOrDescription',
    );
  }

  static Future<String> generateChangelog(String changes, String version) async {
    return getCompletion(
      'You are RepoDoc AI, a changelog generation expert. Generate a professional CHANGELOG entry following Keep a Changelog format. Categorize changes into: Added, Changed, Deprecated, Removed, Fixed, Security. Include dates and version numbers.',
      'Generate changelog for version $version:\n\nChanges:\n$changes',
    );
  }
}
