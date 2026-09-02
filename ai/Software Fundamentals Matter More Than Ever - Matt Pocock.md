# Software Fundamentals Matter More Than Ever — Matt Pocock

In this talk from the **AI Engineer** conference, [Matt Pocock](http://www.youtube.com/watch?v=v4F1gFy-hqg) argues that as AI coding tools become more prevalent, traditional software engineering fundamentals are actually more critical than ever. He pushes back against the "specs-to-code" movement, suggesting that treating code as "cheap" leads to technical debt and entropy.

-----

### Core Philosophy

  * **Code is Not Cheap:** Pocock argues that bad code is more expensive than ever because it prevents AI from being effective. A clean, well-structured codebase allows AI to perform at its best, while a messy one leads to "vibe coding" and systemic collapse [03:52](http://www.youtube.com/watch?v=v4F1gFy-hqg&t=232).
  * **Strategic vs. Tactical:** You should act as the **Strategic Architect**, while the AI acts as the **Tactical Programmer** (the "sergeant on the ground") [17:24](http://www.youtube.com/watch?v=v4F1gFy-hqg&t=1044).

-----

### 5 Key Skills for AI-Assisted Engineering

| Skill | Description | Benefit |
| :--- | :--- | :--- |
| **1. The "Grill Me" Skill** | Instruct the AI to interview you relentlessly about your plan before writing a single line of code [05:58](http://www.youtube.com/watch?v=v4F1gFy-hqg&t=358). | Ensures a shared "design concept" and prevents the AI from building the wrong thing. |
| **2. Ubiquitous Language** | Maintain a markdown file of project-specific terminology that both you and the AI use consistently [08:26](http://www.youtube.com/watch?v=v4F1gFy-hqg&t=506). | Reduces verbosity and keeps the AI aligned with the domain-specific logic. |
| **3. Test-Driven Development** | Force the AI to write a failing test first, then the implementation, then refactor [11:13](http://www.youtube.com/watch?v=v4F1gFy-hqg&t=673). | Keeps the AI from "outrunning its headlights" and ensures small, deliberate steps. |
| **4. Design Deep Modules** | Structure code into deep modules (simple interfaces hiding complex logic) rather than many shallow modules [12:39](http://www.youtube.com/watch?v=v4F1gFy-hqg&t=759). | Makes the codebase easier for AI to navigate and less prone to dependency errors. |
| **5. Delegate Implementation** | Design the high-level interface yourself, but let the AI handle the internal implementation of non-critical modules [16:33](http://www.youtube.com/watch?v=v4F1gFy-hqg&t=993). | Reduces cognitive load, allowing you to treat modules as "gray boxes" while maintaining control. |

### Conclusion

Pocock emphasizes that we must **invest in design every day** [17:03](http://www.youtube.com/watch?v=v4F1gFy-hqg&t=1023). By focusing on these fundamentals, engineers can leverage AI to ship faster without losing control of their systems.

The skills mentioned in the talk are available in his [GitHub repository](https://www.google.com/search?q=https://github.com/mattpocock/mattpocock-skills).

