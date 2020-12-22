﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using NLog;
using Shoko.Server.Settings;

namespace AniDBAPI.Commands
{
    public class AniDBHTTPCommand_GetMyList : AniDBHTTPCommand, IAniDBHTTPCommand
    {
        private static Logger logger = LogManager.GetCurrentClassLogger();

        private List<Raw_AniDB_MyListFile> myListItems = new List<Raw_AniDB_MyListFile>();

        public List<Raw_AniDB_MyListFile> MyListItems
        {
            get => myListItems;
            set => myListItems = value;
        }

        private string username = string.Empty;

        public string Username
        {
            get => username;
            set => username = value;
        }

        private string password = string.Empty;

        public string Password
        {
            get => password;
            set => password = value;
        }

        public string GetKey()
        {
            return "AniDBHTTPCommand_GetMyList";
        }

        public virtual AniDBUDPResponseCode GetStartEventType()
        {
            return AniDBUDPResponseCode.GettingMyListHTTP;
        }

        private void WriteAnimeMyListToFile(string xml)
        {
            string filePath = ServerSettings.Instance.MyListDirectory;

            if (!Directory.Exists(filePath))
                Directory.CreateDirectory(filePath);

            //string fileName = string.Format("MyList_{0}_{1}.xml", DateTime.Now.ToString("yyyyMMdd"), DateTime.Now.ToString("HHmmss"));
            string fileName = "MyList.xml";
            string fileNameWithPath = Path.Combine(filePath, fileName);

            StreamWriter sw;
            sw = File.CreateText(fileNameWithPath);
            sw.Write(xml);
            sw.Close();
        }

        private XmlDocument LoadAnimeMyListFromFile()
        {
            string filePath = ServerSettings.Instance.MyListDirectory;

            if (!Directory.Exists(filePath))
                Directory.CreateDirectory(filePath);

            string fileName = "MyList.xml";
            string fileNameWithPath = Path.Combine(filePath, fileName);

            XmlDocument docAnime = null;
            if (File.Exists(fileNameWithPath))
            {
                StreamReader re = File.OpenText(fileNameWithPath);
                string rawXML = re.ReadToEnd();
                re.Close();

                docAnime = new XmlDocument();
                docAnime.LoadXml(rawXML);
            }

            return docAnime;
        }

        public virtual AniDBUDPResponseCode Process()
        {
            try
            {
                XmlDocument docAnime;
                string xmlResult = AniDBHTTPHelper.GetMyListXMLFromAPI(username, password);
                if (!string.IsNullOrWhiteSpace(xmlResult))
                {
                    WriteAnimeMyListToFile(xmlResult);
                    docAnime = new XmlDocument();
                    docAnime.LoadXml(xmlResult);
                    myListItems = AniDBHTTPHelper.ProcessMyList(docAnime);
                    if (myListItems != null)
                        return AniDBUDPResponseCode.GotMyListHTTP;
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex);
            }

            return AniDBUDPResponseCode.NoSuchAnime;
        }

        public AniDBHTTPCommand_GetMyList()
        {
            commandType = enAniDBCommandType.GetMyListHTTP;
        }

        public void Init(string uname, string pword)
        {
            username = uname;
            password = pword;
            commandID = "MYLIST";
        }
    }
}