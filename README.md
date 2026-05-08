# ClearVoice

**A fork of [Handy](https://github.com/cjpais/Handy) focused on atypical speech transcription using fine-tuned Parakeet models.**

ClearVoice is a cross-platform desktop application for privacy-focused speech transcription, built specifically for people with atypical speech patterns — including stuttering, apraxia, dysarthria, and other speech differences. It runs entirely offline on your own computer.

## Why ClearVoice?

While Handy provides excellent general-purpose transcription, ClearVoice adds:

- **Atypical Speech Support**: Fine-tuned Parakeet models optimized for disfluencies, repetitions, and non-standard speech patterns
- **Custom Cleanup Rules**: Post-processing designed for atypical speech (e.g., handling filler words, repetitions)
- **Multi-Engine**: Supports Whisper, Parakeet, Moonshine, SenseVoice, and more — choose the model that works best for your voice
- **Accessibility First**: Built with the understanding that one size does not fit all speakers

## How It Works

1. **Press** a configurable keyboard shortcut to start/stop recording (or use push-to-talk mode)
2. **Speak** your words while the shortcut is active
3. **Release** and ClearVoice processes your speech using your selected model
4. **Get** your transcribed text pasted directly into whatever app you're using

The process is entirely local:

- Silence is filtered using VAD (Voice Activity Detection) with Silero
- Transcription uses your choice of models:
  - **Whisper models** (Small/Medium/Turbo/Large) with GPU acceleration when available
  - **Parakeet V3** - CPU-optimized model with excellent performance and automatic language detection
  - **Parakeet Atypical** - Fine-tuned for atypical speech patterns (English only, manual setup required)
  - **Moonshine** - Very fast, English only
  - **SenseVoice** - Chinese, English, Japanese, Korean, Cantonese
- Works on Windows, macOS, and Linux

## Quick Start

### Installation

1. Download the latest release from the [releases page](https://github.com/Kasuletrevor/clearvoice/releases)
2. Install the application
3. Launch ClearVoice and grant necessary system permissions (microphone, accessibility)
4. Configure your preferred keyboard shortcuts in Settings
5. Start transcribing!

### Development Setup

For detailed build instructions including platform-specific requirements, see [BUILD.md](BUILD.md).

**Prerequisites:**
- [Rust](https://rustup.rs/) (latest stable)
- [Bun](https://bun.sh/) package manager

```bash
# Install dependencies
bun install

# Run in development mode
bun run tauri dev

# Build for production
bun run tauri build
```

## Architecture

ClearVoice is built as a Tauri application combining:

- **Frontend**: React + TypeScript with Tailwind CSS for the settings UI
- **Backend**: Rust for system integration, audio processing, and ML inference
- **Core Libraries**:
  - `whisper-rs`: Local speech recognition with Whisper models
  - `transcribe-rs`: CPU-optimized speech recognition with Parakeet models
  - `cpal`: Cross-platform audio I/O
  - `vad-rs`: Voice Activity Detection
  - `rdev`: Global keyboard shortcuts and system events
  - `rubato`: Audio resampling

### CLI Parameters

ClearVoice supports command-line flags for controlling a running instance and customizing startup behavior.

**Remote control flags:**

```bash
clearvoice --toggle-transcription    # Toggle recording on/off
clearvoice --toggle-post-process     # Toggle recording with post-processing on/off
clearvoice --cancel                  # Cancel the current operation
```

**Startup flags:**

```bash
clearvoice --start-hidden            # Start without showing the main window
clearvoice --no-tray                 # Start without the system tray icon
clearvoice --debug                   # Enable debug mode with verbose logging
clearvoice --help                    # Show all available flags
```

> **macOS tip:** When ClearVoice is installed as an app bundle, invoke the binary directly:
> ```bash
> /Applications/ClearVoice.app/Contents/MacOS/ClearVoice --toggle-transcription
> ```

## Adding the Atypical Model

The Parakeet Atypical model requires manual placement:

1. Download or export your fine-tuned Parakeet model files:
   - `encoder-model.int8.onnx`
   - `decoder_joint-model.int8.onnx`
   - `nemo128.onnx`
   - `vocab.txt`

2. Place them in the app data directory under `models/parakeet-tdt-atypical-int8/`:
   - **Windows**: `%APPDATA%\computer.clearvoice.app\models\parakeet-tdt-atypical-int8\
   - **macOS**: `~/Library/Application Support/computer.clearvoice.app/models/parakeet-tdt-atypical-int8/
   - **Linux**: `~/.config/computer.clearvoice.app/models/parakeet-tdt-atypical-int8/

3. Restart ClearVoice — the model will appear in Settings → Models

## Relationship to Handy

ClearVoice is a friendly fork of [Handy](https://github.com/cjpais/Handy) by CJ Pais. We are grateful for the incredible foundation Handy provides and aim to contribute improvements back upstream where appropriate.

Key differences from Handy:
- Added Parakeet Atypical model support
- Rebranded UI and assets
- Future: custom post-processing rules for atypical speech

## License

MIT License — see [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Handy](https://github.com/cjpais/Handy) by CJ Pais — the foundation this fork is built on
- [Whisper](https://github.com/openai/whisper) by OpenAI for the speech recognition model
- [whisper.cpp](https://github.com/ggerganov/whisper.cpp) and ggml for amazing cross-platform whisper inference
- [transcribe-rs](https://github.com/rivet-gg/transcribe-rs) for Parakeet ONNX inference
- [Silero](https://github.com/snakers4/silero-vad) for great lightweight VAD
- [Tauri](https://tauri.app) team for the excellent Rust-based app framework
