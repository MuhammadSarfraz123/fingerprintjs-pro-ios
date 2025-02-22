//
//  TagEditorView.swift
//  DemoSPM
//
//  Created by Petr Palata on 06.09.2022.
//

import SwiftUI

struct TagEditorView: View {

    @Binding var tags: [TagTuple]
    @State private var tag: TagTuple?
    @State private var editing = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                if editing {
                    TagEditorCardView(tag: $tag, editing: $editing)
                } else {
                    Button(
                        action: {
                            editing = true
                        },
                        label: {
                            Text("Add Tag")
                                .frame(maxWidth: .infinity, minHeight: 40)
                        }
                    )
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(.fingerprintRed)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical, 16)
                    .padding(.top, -16)
                }

                ForEach(Array(zip(tags.indices, tags)), id: \.0) { index, tag in
                    TagRow(
                        tag: tag,
                        deleteAction: {
                            tags.remove(at: index)
                        }
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .onChange(of: editing) { _ in
                if let tag = self.tag {
                    tags.append(tag)
                    self.tag = nil
                }
            }
            .padding()
        }
    }
}

struct TagEditorView_Previews: PreviewProvider {

    struct Example: View {
        @State var tags: [TagTuple] = [
            (key: "Test", value: 10),
            (key: "Test", value: 10)
        ]

        var body: some View {
            TagEditorView(tags: $tags)
        }
    }

    static var previews: some View {
        TagEditorView_Previews.Example()
    }
}
