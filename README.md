# github_calendar

A calendar view like github repo contributions.

![preview](art/github_calendar_preview.png)

## Getting Started

```yml
   github_calendar: ^0.0.1
```

## Usage

```dart
Container(
  height: 200,
  child: GithubCalendar(
    color: Colors.pink,
    degresses: List.generate(371, (index){
      return Random().nextInt(5);
      }),
    )
  )
```

