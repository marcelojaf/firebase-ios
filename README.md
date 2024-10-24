# iOS Analytics Test Lab

Um aplicativo iOS para testar e validar a implementação do Firebase Analytics e Crashlytics.

## Sobre o Projeto

Este aplicativo serve como um laboratório de testes para funcionalidades do Firebase, permitindo:
- Testar eventos personalizados do Analytics
- Capturar e registrar exceções controladas
- Monitorar crashes do aplicativo

## Requisitos

- Xcode 15.0+
- iOS 17.0+
- Uma conta no [Firebase Console](https://console.firebase.google.com/)
- Swift Package Manager (SPM)

## Configuração

### 1. Firebase Setup
1. Crie um novo projeto no [Firebase Console](https://console.firebase.google.com/)
2. Adicione um novo aplicativo iOS
   - Bundle ID: `com.cklabs.analyticstestlab` (ou seu bundle identifier personalizado)
3. Baixe o arquivo `GoogleService-Info.plist`
4. Adicione o arquivo ao projeto Xcode (não inclua no controle de versão)

### 2. Dependências (via SPM)
1. No Xcode, vá para File > Add Packages
2. Cole a URL: `https://github.com/firebase/firebase-ios-sdk`
3. Selecione os pacotes:
   - FirebaseAnalytics
   - FirebaseCrashlytics

### 3. Configuração do Crashlytics
1. Em Build Settings, configure:
   - Debug Information Format: DWARF with dSYM File (Debug e Release)
2. Em Build Phases, adicione um novo Run Script:
```bash
${BUILD_DIR%Build/*}SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run
```

## Funcionalidades

### Analytics Events
1. App Open (automático)
   - Registrado quando o app é iniciado
   - Inclui versão do app e plataforma

2. Counter Increment
   - Registrado quando o contador é incrementado
   - Parâmetros:
     ```swift
     Analytics.logEvent("counter_increment", parameters: [
         "counter_value": value,
         "timestamp": timestamp
     ])
     ```

3. Controlled Exception
   - Registrado quando uma exceção controlada é gerada
   - Parâmetros:
     ```swift
     Analytics.logEvent("controlled_exception", parameters: [
         "error_description": description,
         "error_code": code,
         "timestamp": timestamp
     ])
     ```

## Desenvolvimento

### Running the App
1. Abra `ioslytics.xcodeproj` no Xcode
2. Selecione o target iOS e um simulador/dispositivo
3. Execute o projeto (⌘R)

### Testing Crashlytics
1. Force um crash usando o botão "Force App Crash"
2. Reabra o app para enviar o relatório de crash
3. Verifique o console do Firebase em alguns minutos

## Troubleshooting

### Missing dSYM Files
Se receber email sobre dSYM ausente:
1. Abra Window > Organizer no Xcode
2. Encontre o archive específico
3. Show Package Contents > dSYMs
4. Faça upload manual no Firebase Console ou configure o script automático

### Crashes não aparecem no Console
1. Certifique-se de reabrir o app após o crash
2. Verifique sua conexão com a internet
3. Aguarde alguns minutos para o processamento

## Arquivos Ignorados

O seguinte arquivo contém informações sensíveis e não está incluído no repositório:
```
GoogleService-Info.plist
```
Você precisará obter sua própria cópia do Firebase Console.

## Estrutura do Projeto

```
ioslytics/
├── App.swift              # Configuração do Firebase e Entry Point
├── ContentView.swift      # Interface principal do usuário
└── Assets.xcassets/       # Recursos de imagem e cores
```

## Suporte

Para questões relacionadas ao Firebase:
- [Firebase Analytics Documentation](https://firebase.google.com/docs/analytics)
- [Firebase Crashlytics Documentation](https://firebase.google.com/docs/crashlytics)

## Notas de Desenvolvimento

- O app usa SwiftUI para a interface do usuário
- A configuração do Firebase é feita no AppDelegate
- Os eventos do Analytics são consistentes em todas as plataformas do projeto
- Os crashes são automaticamente reportados quando o app é reaberto

## Contribuição

1. Fork o projeto
2. Crie sua Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a Branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request