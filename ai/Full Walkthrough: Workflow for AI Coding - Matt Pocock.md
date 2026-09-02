# Full Walkthrough: Workflow for AI Coding — Matt Pocock

In this hands-on workshop, [Matt Pocock](https://www.youtube.com/watch?v=-QFHIoCo-Ko) details a robust workflow for AI-assisted software development. He argues that while AI is a new paradigm, success depends on traditional software engineering fundamentals: small tasks, strong feedback loops, and human-in-the-loop oversight.

### **The Core Philosophy**

Pocock emphasizes moving away from "specs-to-code" (where developers ignore the code) and toward **intentional engineering**. He identifies two major constraints of LLMs:

* **The Smart Zone vs. Dumb Zone:** LLMs perform best at the start of a conversation. As context grows (around **100k tokens**), they become "dumber" and more prone to errors [03:07](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=187).
* **The "Memento" Effect:** LLMs effectively "reset" every session. Developers should optimize for this by keeping tasks small and clear [07:31](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=451).

---

### **The 6-Phase Workflow**

| Phase | Description | Key Concept |
| --- | --- | --- |
| **1. Grilling** | Use a "Grill Me" skill where the AI relentlessly questions you about edge cases and requirements [12:19](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=739). | **Alignment:** Reach a shared design concept before any code is written. |
| **2. The PRD** | Summarize the grilling session into a Product Requirements Document (PRD) [30:35](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=1835). | **Destination:** Define the "Done" state without over-optimizing the text. |
| **3. Slicing** | Break the PRD into "vertical slices" (Tracer Bullets) that hit every layer of the system (DB, API, UI) [41:41](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2501). | **Feedback:** Avoid horizontal coding (layer-by-layer) to get early system feedback. |
| **4. AFK Execution** | Hand off the Kanban board to an AI agent to work "Away From Keyboard" [53:07](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=3187). | **Parallelization:** Run multiple agents on independent tasks. |
| **5. TDD & Loops** | Use Test-Driven Development (TDD) where the AI writes a failing test first (Red) then the fix (Green) [01:06:46](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4006). | **Reliability:** Feedback loops (tests, types, linting) are the ceiling for AI quality. |
| **6. Human Review** | The developer steps back in to QA the work, imposing "taste" and architecture [01:12:45](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4365). | **Oversight:** Humans manage intention; agents manage implementation. |

---

### **Key Technical Takeaways**

* **Deep Modules:** Design codebase architecture with "deep" modules (simple interfaces, complex internal logic) to make them easier for AI to test and navigate [01:16:55](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=4615).
* **Documentation Rot:** Pocock warns against keeping old PRDs in the repo, as outdated docs can confuse agents later on [01:24:10](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=5050).
* **Push vs. Pull:** "Push" coding standards to a separate AI reviewer, but allow the implementer agent to "Pull" information as needed [01:28:10](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=5290).

> "A bad codebase makes for a bad agent. If you have a garbage codebase, you're going to get garbage out." [36:57](http://www.youtube.com/watch?v=-QFHIoCo-Ko&t=2217)

For more resources and the workshop exercises, you can visit [AI Hero](https://aihero.dev).

