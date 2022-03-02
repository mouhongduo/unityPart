using System;
using UnityEditor;
using UnityEngine;

namespace PSDUIImporter
{
    //------------------------------------------------------------------------------
    // class definition
    //------------------------------------------------------------------------------
    public class PSDImportMenu : Editor
    {
        [MenuItem("UITool/PSDImport ...", false, 1)]
        static public void ImportPSD()
        {
            string inputFile = EditorUtility.OpenFilePanel("Choose PSDUI File to Import", Application.dataPath, "xml");

            if (!string.IsNullOrEmpty(inputFile) &&
                inputFile.StartsWith(Application.dataPath))
            {
                PSDImportCtrl import = new PSDUIImporter.PSDImportCtrl(inputFile);
                import.BeginDrawUILayers();
                import.BeginSetUIParents();
                import.AddInjections();
                import.SaveUIAsPrefab();
                import.GenerateCode();
            }

            GC.Collect();
        }
    }
}