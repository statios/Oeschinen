//
//  Content+Sample.swift
//  Example
//
//  Created by stat on 5/22/24.
//

import Foundation
import Oeschinen

var headerContent: Content {
    Content(
        title: "홍길동",
        subtitle: "Kildong Hong",
        description: "—\niOS Developer",
        children: [
            Content(
                title: "Email",
                description: "abc@email.com"
            ),
            Content(
                title: "Phone",
                description: "123-4567-8901"
            ),
            Content(
                title: "Website",
                description: "https://www.example.com"
            )
        ]
    )
}

var sideContents: [Content] {
    [
        Content(
            title: "About me",
            description: """
                         With several years of experience in the IT field, I have successfully led and executed various projects. My strengths lie particularly in software development and data analysis, and I consistently deliver optimal results through teamwork and problem-solving skills. I embrace new challenges and continuously seek to grow by staying updated with rapidly evolving technology trends. I am eager to contribute to your company’s growth with my expertise and passion.
                         """
        ),
        Content(
            title: "Skills",
            children: [
                Content(
                    title: "framework & library",
                    description: "UIKit, SwiftUI, Combine, WebKit, PencilKit, PDFKit, StoreKit, CoreNFC, RxSwift, Realm, Moya, SnapKit"
                ),
                Content(
                    title: "library",
                    description: "RxSwift, Realm, Firebase, Appsflyer, Moya, Kingfisher, Lottie, SnapKit"
                ),
                Content(
                    title: "architecture",
                    description: "ReactorKit, MVVM, RIBs, Clean Architecture"
                ),
                Content(
                    title: "tool",
                    description: "slack, jira, confluence, notion, figma, fastlane, github action"
                )
            ]
        ),
        Content(
            title: "Education",
            children: [
                Content(
                    title: "My University",
                    description: "Computer Science\n2024 - 2029")
            ]
        )
    ]
}

var sectionContents: [Content] {
    [
        Content(
            title: "Work Experience",
            children: [
                Content(
                    title: "Company ABC",
                    subtitle: "2026. 2 - Present",
                    description: "Marketing coordinator",
                    children: [
                        Content(
                            title: "Simba Project",
                            description: """
                                         Social Media Campaign Management
                                          • Coordinated cross-platform campaigns on Facebook
                                          • Automated scheduling of posts using Hootsuite
                                         Content Creation and Strategy Development
                                          • Developed blog content and managed calendar
                                          • Created and optimized content for SEO
                                          • Automated scheduling of posts using Hootsuite
                                         """
                        )
                    ]
                ),
                Content(
                    title: "Organization XYZ",
                    subtitle: "2043. 3 - 2023. 2",
                    description: "Graphic Designer",
                    children: [
                        Content(
                            title: "Boosting Online Engagement",
                            description: """
                                         In my previous role as a Marketing Coordinator at XYZ Company, I led the development and execution of a comprehensive social media campaign that significantly boosted our online presence and engagement. This project involved coordinating cross-platform campaigns on Facebook, Instagram, and Twitter, and utilizing Hootsuite for automated post scheduling.
                                         """
                        ),
                        Content(
                            title: "Social Media Success",
                            description: """
                                         Additionally, I implemented A/B testing for email marketing, automated customer segmentation, and integrated Mailchimp with our CRM. These efforts increased our follower base by 30% and improved email open rates by 25%.
                                         """
                        ),
                        Content(
                            title: "Optimized Email Marketing",
                            description: """
                                          • Created and optimized content for SEO
                                          • visual assets library for the marketing team
                                         """
                        ),
                        Content(
                            title: "Improved SEO Performance",
                            description: """
                                         d posts for SEO. Additionally, I enhanced our email marketing efforts by implementing A/B testing for email subject lines and content, automating customer segmentation, and integrating Mailchimp with our CRM system for better data synchronization. These initiatives not only increased ou
                                         """
                        ),
                        Content(
                            title: "Social Media Campaign Management",
                            description: """
                                         Social Media Campaign Management
                                          • Coordinated cross-platform campaigns on Facebook
                                          • Automated scheduling of posts using Hootsuite
                                         Content Creation and Strategy Development
                                          • Developed blog content and managed calendar
                                          • Created and optimized content for SEO
                                         Content Creation and Strategy Development
                                          • Developed blog content and managed calendar
                                          • Created and optimized content for SEO
                                         """
                        )
                    ]
                ),
                Content(
                    title: "Corporation EFG",
                    subtitle: "2099. 9 - 2077. 5",
                    description: "Graphic Designer",
                    children: [
                        Content(
                            title: "Brand website redesign",
                            description: """
                                          • Developed blog content and managed calendar
                                          • Created and optimized content for SEO
                                          • visual assets library for the marketing team
                                         """
                        )
                    ]
                ),
            ]
        ),
        Content(
            title: "Other Experience",
            children: [
                Content(
                    title: "2099 Design Competition",
                    subtitle: "2099. 9",
                    description: "Graphic Designer",
                    children: [
                        Content(
                            title: "Award-winning Design",
                            description: """
                                         My design for the 2099 Design Competition was selected as the winning entry out of over 100 submissions. The design was praised for its innovative approach and creativity, and I was awarded a cash prize of $5,000.
                                         """
                        )
                    ]
                ),
            ]
        )
    ]
}

var footnote: String {
    """
    This resume was generated using Oeschinen
    """
}

